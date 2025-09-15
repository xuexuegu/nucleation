clear all;
close all force;
tic;

%% --- Simulation Parameters ---
n = 500;                    % Number of molecules per cell
Nc = 200;                   % Number of simulation runs (cells)
params.rc = 2.0;            % Radius of the cell
params.or_s = [0.32];       % Organelle (vacuole) volume ratios
params.merge_dis = 1.9;     % Merge threshold distance

nr = length(params.or_s);

%% --- Preallocate Result Arrays ---
number = zeros(nr, Nc);
size_val = zeros(nr, Nc);
number_aver = zeros(nr, 1);
size_aver = zeros(nr, 1);

h = waitbar(0, 'Starting simulation...');

for or_index = 1:nr
    % Inner (vacuole) radius from volume fraction
    r_inner = params.rc * (params.or_s(or_index)^(1/3));

    for cn = 1:Nc
        %% Generate initial molecule positions in spherical shell: [r_inner, rc]
        rand_shell = rand(n, 1);
        radius_dist = nthroot((params.rc^3 - r_inner^3) * rand_shell + r_inner^3, 3);
        theta = 2 * pi * rand(n, 1);
        phi = acos(2 * rand(n, 1) - 1);

        molecule_position = zeros(n, 4);
        molecule_position(:,1) = radius_dist .* sin(phi) .* cos(theta);
        molecule_position(:,2) = radius_dist .* sin(phi) .* sin(theta);
        molecule_position(:,3) = radius_dist .* cos(phi);
        molecule_position(:,4) = 1;  % initial radius (arbitrary unit)

        n_left = n;

        while n_left > 1
            % Build KD-tree on current active points
            active_points = molecule_position(1:n_left, 1:3);
            kdtree = KDTreeSearcher(active_points);
            [idx, ~] = knnsearch(kdtree, active_points, 'k', 10);

            % Global minimum under dynamic-style path length around inner sphere
            dis_min = inf; p_best = -1; q_best = -1;

            for i = 1:n_left
                j = idx(i, 2); 
                if i < j
                    d = calculateDistance_dynamic(active_points(i,:), active_points(j,:), r_inner);
                    if d < dis_min
                        dis_min = d; p_best = i; q_best = j;
                    end
                end
            end

            % Stopping rule unchanged
            if dis_min > params.merge_dis
                break;
            end

            % ---- Merge the best pair: 
            p = p_best; q = q_best;

            rp = molecule_position(p,4);
            rq = molecule_position(q,4);

            pos_p = molecule_position(p,1:3);
            pos_q = molecule_position(q,1:3);

           
            new_pos = (pos_p + pos_q)/2;
          
            new_rad = (rp^3 + rq^3)^(1/3);

            
            d_new = norm(new_pos);
            if d_new < r_inner
                if d_new ~= 0
                    new_pos = new_pos * (r_inner / d_new);
                else
                    direction = pos_p - pos_q;
                    if all(direction == 0)
                        direction = getRandomPerpendicularVector(rand(1,3));
                    end
                    direction = direction / norm(direction);
                    new_pos = r_inner * direction;
                end
            end
         

            % Commit merge: overwrite p with merged cluster, remove q by swapping with last
            molecule_position(p,1:3) = new_pos;
            molecule_position(p,4)   = new_rad;
            molecule_position(q,:)   = molecule_position(n_left,:); % swap in last active
            n_left = n_left - 1;
        end

        % Log results for this cell
        number(or_index, cn)    = n_left;
        size_val(or_index, cn)  = mean(molecule_position(1:n_left,4));

        % Update progress
        progress_val = (Nc*(or_index-1)+cn)/(nr*Nc);
        waitbar(progress_val, h, sprintf('Progress: %.1f%%', progress_val*100));
    end

    % Aggregate per or_s
    number_aver(or_index) = mean(number(or_index,:));
    size_aver(or_index)   = mean(size_val(or_index,:));

    % Plot distribution of final counts for this or_s
    figure(1);
    subplot(1, nr, or_index);
    [uniqueValues, ~, index] = unique(number(or_index, :));
    counts = accumarray(index, 1);
    bar(uniqueValues, counts);
    xlabel('Final P-body count');
    ylabel('Number of cells');
    title(['Organelle Ratio: ', num2str(params.or_s(or_index))]);
end

suptitle('Distribution of P-body counts');
close(h);

%% --- Final Box Plot ---
figure(2);
boxplot(size_val', 'Labels', strsplit(num2str(params.or_s)));
title('P-body Size vs. Organelle Ratio');
xlabel('Organelle Ratio');
ylabel('Average P-body Size');


clear all;
close all force;
tic;

n = 100;% number of molecule per cell
progress = waitbar(0,'processing...');
Nc = 200;
rc =2.5;% radium of cell size
or_s = [0.0384 0.0456];
merge_dis = 2.0;
nr = length(or_s);
number = zeros(nr,Nc);
size = zeros(nr,Nc);
number_aver = zeros(nr,1);
size_aver = zeros(nr,1);
for or_index = 1:1:nr
    for cn = 1:1:Nc
        molecule_position = ones(n,4);
        n_left = n; %molecule remain
        angle1=rand(1,n)*2*pi;
        angle2=acos(rand(1, n)*2-1);
        r=rc*(or_s(or_index)^(1/3)+power((1-or_s(or_index))*rand(1,n),1/3));
        molecule_position(:,1)=r.*cos (angle1).*sin (angle2);
        molecule_position(:,2)=r.*sin(angle1).*sin(angle2);
        molecule_position(:,3)=r.*cos (angle2);
        molecule_position_initial = molecule_position;
        dis = 0;
        i1 = 0;
        %         for i = 1:1:(n-1)
        %             dis_min= inf;
        %             %intersect_all = 1;
        %             for j = 1:1:(n-i)
        %                 for k = 1:1:(n-i-j)
        %                     dis = sum((molecule_position(j,1:3)-molecule_position(j+k,1:3)).^2);
        %                     %intersect = isLineIntersectSphere(molecule_position(j,1:3), molecule_position(j+k,1:3),rc*or_s(or_index)^(1/3));
        %                     %if dis < dis_min && intersect==0
        %                     if dis < dis_min
        %                         %intersect_all = 0;
        %                         dis_min = dis;
        %                         p = j;
        %                         q = j+k;
        %                     end
        %                 end
        %             end
        for i = 1:1:(n-1)
            dis_min= inf;
            for j = 1:1:(n-i)
                [k,dis] = findclosestpoint(molecule_position(1:(n-i+1),1:3),j,rc*or_s(or_index)^(1/3),rc);
                if dis < dis_min
                    dis_min = dis;
                    p = j;
                    q = k;
                end
            end
            %if (dis_min > merge_dis^2) || intersect_all == 1
            if (dis_min > merge_dis^2)
                i1 = 1;
                break;
            end
            a = molecule_position(p,4).^3;
            b = molecule_position(q,4).^3;
            %             if molecule_position(p,4)>molecule_position(q,4)
            %                 molecule_position(p,1:3) = molecule_position(p,1:3);
            %
            %             elseif molecule_position(p,4)==molecule_position(q,4)
            %                 random_index = randi([0,1]);
            %                 molecule_position(p,1:3) = (1-random_index)*molecule_position(p,1:3)+random_index*molecule_position(q,1:3);
            %             else
            %                 molecule_position(p,1:3) = molecule_position(q,1:3);
            %             end
            postion_ori = (molecule_position(p,1:3)*a+molecule_position(q,1:3)*b)/(a+b);
            postion_ori_dis = sum(postion_ori.^2);
            if postion_ori_dis>=(rc*or_s(or_index)^(1/3))^2
                molecule_position(p,1:3) = postion_ori;
            elseif postion_ori_dis~=0
                molecule_position(p,1:3) = postion_ori*sqrt(rc/postion_ori_dis);
            else
                randomvector = getRandomPerpendicularVector(molecule_position(p,1:3)-molecule_position(q,1:3));
                molecule_position(p,1:3) = or_s(or_index)*randomvector;
            end
            molecule_position(p,1:3) = (molecule_position(p,1:3)*a+molecule_position(q,1:3)*b)/(a+b);
            molecule_position(p,4) = molecule_position(p,4)+molecule_position(q,4);
            if q ~= n
                molecule_position(q:n-1,:) = molecule_position(q+1:n,:);
                molecule_position((n-i+1):n,:) = zeros(i,4);
            else
                molecule_position(q,:) = 0;
            end
        end
        t = toc;
        t_remain = sec2hms(round(t/((Nc*(or_index-1)+cn)/(nr*Nc))));
        str=['cauculating',num2str((Nc*(or_index-1)+cn)/(nr*Nc)),'% time left: ',t_remain];
        waitbar((Nc*(or_index-1)+cn)/(nr*Nc),progress,str);

        number(or_index,cn) = n-i+i1;
        size(or_index,cn) = mean(molecule_position(1:(n-i+i1),4).^(1/3));
    end


    number_aver(or_index) = mean(number(or_index,:));
    size_aver(or_index) = mean(size(or_index,:));
    figure(1);
    subplot(1,nr,or_index);
    [uniqueValues, ~, index] = unique(number(or_index,:));
    counts = accumarray(index, 1);
    % plot
    bar(uniqueValues, counts);
    % add label and title
    xlabel('P body numbers');
    ylabel('cell numbers');
    str = [num2str(or_s(or_index)),'%'];
    title(str);
end
sgtitle('points left in 200 times simulation');
close(progress);

figure;
% box chart
h1 = boxplot(size','Labels', {'0%','1%', '7%','10%'});
for i = 1:length(h1)
    boxHandle = h1(i);
end
% add title and label
% x axis
% y axis
color = ['g', 'r', 'm', 'bl'];
h2 = findobj(gca,'Tag','Box');
% for j=1:length(h2)
%    patch(get(h2(j),'XData'),get(h2(j),'YData'),color(j),'FaceAlpha',.5);
% end
%axis([0,5,0,3]);
title('P-body size/nucleus+organize rate chart');
xlabel('nucleus+organize rate');
ylabel('P-body size');
% ????è½´ç???

set(gca, 'Box', 'on', ...                                        %
    'LineWidth', 1,...                                      %
    'XGrid', 'off', 'YGrid', 'off', ...                     %
    'TickDir', 'in', 'TickLength', [.015 .015], ...         %
    'XMinorTick', 'off', 'YMinorTick', 'off', ...           %
    'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])            %
%
set(gca, 'FontName', 'Helvetica')




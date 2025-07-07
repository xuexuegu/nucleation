clear all;
close all;
tic;
rc = 2;% radium of cell size
n = 200;% number of molecule per cell
progress = waitbar(0,'æ­£å?¨å???...');
molecule_position = ones(n,4);
n_left = n; %molecule remain
angle1=rand(1,n)*2*pi;
angle2=acos(rand(1, n)*2-1);
r=rc*power(rand(1,n),1/3);
molecule_position(:,1)=r.*cos (angle1).*sin (angle2);
molecule_position(:,2)=r.*sin(angle1).*sin(angle2);
molecule_position(:,3)=r.*cos (angle2);
molecule_position_initial = molecule_position;
dis = 0;
i1 = 0;
fig = figure('Position', [150, 100, 1200, 600]);
for i = 1:1:(n-1)
    progress = waitbar(i/n,progress);
    dis_min= inf;
    for j = 1:1:(n-i)	
         [k,dis] = findclosestpoint(molecule_position(1:(n-i),1:3),j);
         if dis < dis_min
            dis_min = dis;
            p = j;
            q = k;
         end
    end
    if (dis_min > 3^2)
        i1 = 1;
        break;
    else
        if q ~= n
            a = molecule_position(p,4).^3;
            b = molecule_position(q,4).^3;
            molecule_position(p:n-1,1:3) = (molecule_position(p:n-1,1:3)*a+molecule_position(p:n-1,1:3)*b)/(a+b);
            molecule_position(p,4) = molecule_position(p,4)+molecule_position(q,4);
            molecule_position(q:n-1,:) = molecule_position(q+1:n,:);
            molecule_position((n-i+1):n,:) = zeros(i,4);
        end
    end
    clf;
    subplot(1,2,1);
    plot3(molecule_position_initial(:,1),molecule_position_initial(:,2),molecule_position_initial(:,3),'r.');
    axis square;
    xlim([-4, 4]); % è®¾ç½®Xè½´è????
    ylim([-4, 4]); % è®¾ç½®Yè½´è????
    zlim([-4, 4]); % è®¾ç½®Zè½´è????
    title('molecule position initial'); % æ·»å????é¢?
    xlabel('/Î¼m');
    ylabel('/Î¼m');
    zlabel('/Î¼m');
    subplot(1,2,2);
    [x1,y1,z1] = sphere(); % è¿?????50è¡¨ç¤º??ä½?è¢?????50ä»?
    h1 = surf(x1*rc, y1*rc, z1*rc);
    h1.FaceAlpha = 0.1;%?§å?¶ç????????åº?ï¼?
    h1.EdgeAlpha = 0.2;%?§å?¶ç????????åº?ï¼?
    colormap summer; % ???©é??²æ???æ¨¡å?
    grid off; % ?³é??ç½??¼çº¿
    axis equal;
    for m = 1:(n-i+i1)
        radius = 0.1*[molecule_position(m,4)].^(1/3); % ??ä½???å¾?
        center = [molecule_position(m,1), molecule_position(m,2), molecule_position(m,3)]; % ??ä½?ä¸?å¿??¹ä?ç½?
    
        [x, y, z] = sphere(20); % è¿?????20è¡¨ç¤º??ä½?è¢?????å¤?å°?ä»?
     
        % å°???ä½?ç§»å?¨å?°æ??å®?ä½?ç½?å¹¶è?è¡?ç¼©æ??
        scaled_x = radius*x + center(1);
        scaled_y = radius*y + center(2);
        scaled_z = radius*z + center(3);
     
        % ç»??¶ç??ä½?
        hold on;
        h2 = surf(scaled_x', scaled_y', scaled_z');
        shading interp; % æ·»å????å½±æ????
        colormap summer; % ???©é??²æ???æ¨¡å?
        title('merge model simulation'); % æ·»å????é¢?
        xlabel('/Î¼m');
        ylabel('/Î¼m');
        zlabel('/Î¼m');
        grid off; % ?³é??ç½??¼çº¿
        
    end
    view(3); % è®¾ç½®è§??¹å??è§?è§?
    axis equal; % è®¾ç½®????è½´æ??ä¾??¸ç??
    xlim([-4, 4]); % è®¾ç½®Xè½´è????
    ylim([-4, 4]); % è®¾ç½®Yè½´è????
    zlim([-4, 4]); % è®¾ç½®Zè½´è????
    pause(0.1);
    frame = getframe(fig);
    im{i} = frame2im(frame);
end
filename = 'D:\simulation\Animation.gif'; 
for idx = 1:(i-i1)
    % ?¶ä?gif??ä»?
    time_delay = 0.1*idx/(i-i1);
    [A, map] = rgb2ind(im{idx}, 256);
    if idx == 1
        imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', 3);
    elseif idx <=(i-i1)*0.25 && idx >1
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
    elseif idx <=(i-i1)*0.5 && idx >(i-i1)*0.25
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.08);
    elseif idx <=(i-i1)*0.75 && idx >(i-i1)*0.5
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
    elseif idx <=(i-i1)*0.9 && idx >(i-i1)*0.75
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.2);
    elseif idx <(i-i1) && idx >(i-i1)*0.9
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    else
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime',3);
    end
    t = toc;
    t_remain = sec2hms(t/(i/(n-1)));
    str=['è®¡ç??ä¸?...',num2str((100*t/(i/(n-1)))),'%é¢?è®¡å?©ä??¶é??',t_remain];
end
close(progress);




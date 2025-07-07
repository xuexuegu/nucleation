clear all;
close all;
tic;

n = 1000;% number of molecule per cell
progress = waitbar(0,'正�?��???...');
Nc = 100;
rc = [2.5];% radium of cell size
nr = length(rc);
number = zeros(nr,Nc);
size = zeros(nr,Nc);
number_aver = zeros(nr,1);
size_aver = zeros(nr,1);
for rc_index = 1:1:nr
for cn = 1:1:Nc
    molecule_position = ones(n,4);
    n_left = n; %molecule remain
    angle1=rand(1,n)*2*pi;
    angle2=acos(rand(1, n)*2-1);
    r=rc(rc_index)*power(rand(1,n),1/3);
    molecule_position(:,1)=r.*cos (angle1).*sin (angle2);
    molecule_position(:,2)=r.*sin(angle1).*sin(angle2);
    molecule_position(:,3)=r.*cos (angle2);
    molecule_position_initial = molecule_position;
    dis = 0;
    i1 = 0;
    for i = 1:1:(n-1)
        dis_min= inf;
        for j = 1:1:(n-i)	
             [k,dis] = findclosestpoint(molecule_position(1:(n-i+1),1:3),j);
             if dis < dis_min
                dis_min = dis;
                p = j;
                q = k;
             end
        end

        if (dis_min > 2.5^2)
            i1 = 1;
            break;
        end
        a = molecule_position(p,4).^3;
        b = molecule_position(q,4).^3;
        molecule_position(p:n-1,1:3) = (molecule_position(p:n-1,1:3)*a+molecule_position(p:n-1,1:3)*b)/(a+b);
        molecule_position(p,4) = molecule_position(p,4)+molecule_position(q,4);
        if q ~= n
            molecule_position(q:n-1,:) = molecule_position(q+1:n,:);
            molecule_position((n-i+1):n,:) = zeros(i,4);
        else
            molecule_position(q,:) = 0;
        end
        t = toc;
        t_remain = sec2hms(t/(((cn-1)*(n-1)+i)/(nr*Nc*(n-1))));
        str=['计�??�?...',num2str(((cn-1)*(n-1)+i)/(nr*(n-1))),'%�?计�?��??��??',t_remain];
        waitbar(((cn-1)*(n-1)+i)/(nr*Nc*(n-1)),progress,str);
    end
    number(rc_index,cn) = n-i+i1;
    size(rc_index,cn) = mean(molecule_position(1:(n-i+i1),4).^(1/3));
end

number_aver(rc_index) = mean(number(rc_index,:));
size_aver(rc_index) = mean(size(rc_index,:));
figure(1);
subplot(1,nr,rc_index);
[uniqueValues, ~, index] = unique(number(rc_index,:));  
counts = accumarray(index, 1);
% �??��?�形?? 
bar(uniqueValues, counts);
% 添�????签�????�?
xlabel('point left');  
ylabel('numbers');
str = [num2str(rc(rc_index)),'μm'];
title(str);
end
sgtitle('points left in 200 times simulation');
close(progress);

figure(2);
% ??建�?�线?�并?��???��??  
h1 = boxplot(size','Labels', {'2μm', '2.5μm', '3μm'});  
for i = 1:length(h1)  
    boxHandle = h1(i);        
end  
% 添�????�???轴�??�?
% 设置x轴�??????  
% 设置y轴�?????? 
color = ['g', 'r', 'm', 'bl'];
h2 = findobj(gca,'Tag','Box');
% for j=1:length(h2)
%    patch(get(h2(j),'XData'),get(h2(j),'YData'),color(j),'FaceAlpha',.5);
% end
axis([0,5,0,5]); 
title('P-body size/Cell size chart');  
xlabel('Cell size');  
ylabel('P-body size');
% ????轴�???

set(gca, 'Box', 'on', ...                                        % 边�?
         'LineWidth', 1,...                                      % 线�??
         'XGrid', 'off', 'YGrid', 'off', ...                     % �???
         'TickDir', 'in', 'TickLength', [.015 .015], ...         % ?�度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...           % �??�度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])            % ????轴�???
% �?�???�???
set(gca, 'FontName', 'Helvetica')




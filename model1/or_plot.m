clear all;
close all;
rc = 3;% radium of cell size
or_s = 0.15;
n = 1000;% number of molecule per cell
molecule_position = ones(n,4);
n_left = n; %molecule remain
angle1=rand(1,n)*2*pi;
angle2=acos(rand(1, n)*2-1);
r=rc*(or_s^(1/3)+power((1-or_s)*rand(1,n),1/3));
molecule_position(:,1)=r.*cos (angle1).*sin (angle2);
molecule_position(:,2)=r.*sin(angle1).*sin(angle2);
molecule_position(:,3)=r.*cos (angle2);
molecule_position_initial = molecule_position;
dis = 0;
i1 = 0;
% 定义半径  
k = rc*(or_s^(1/3));  
% 生成球坐标数据  
[theta, phi] = meshgrid(linspace(0, 2*pi, 50), linspace(0, pi, 50));  
x = k * sin(phi) .* cos(theta);  
y = k * sin(phi) .* sin(theta);  
z = k * cos(phi);  
  
% 绘制球体  
surf(x, y, z,'FaceColor', 'k');
xlabel('X')  
ylabel('Y')  
zlabel('Z')  
title(['半径为 ', num2str(k), ' 的球体'])  

hold on
plot3(molecule_position_initial(:,1),molecule_position_initial(:,2),molecule_position_initial(:,3),'r.');
axis square;
xlim([-4, 4]); % 设置X轴范围
ylim([-4, 4]); % 设置Y轴范围
zlim([-4, 4]); % 设置Z轴范围
title('molecule position initial'); % 添加标题
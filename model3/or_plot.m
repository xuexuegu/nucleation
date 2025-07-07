clear all;
close all;
rc = 3;% radium of cell size
or_s = 0.01;
n = 100;% number of molecule per cell
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
% å®?ä¹???å¾?  
k = rc*(or_s^(1/3));  
% ???????????°æ??  
[theta, phi] = meshgrid(linspace(0, 2*pi, 50), linspace(0, pi, 50));  
x = k * sin(phi) .* cos(theta);  
y = k * sin(phi) .* sin(theta);  
z = k * cos(phi);  
  
% ç»??¶ç??ä½?  
surf(x, y, z,'FaceColor', 'k');
xlabel('X')  
ylabel('Y')  
zlabel('Z')  
title(['??å¾?ä¸? ', num2str(k), ' ????ä½?'])  

hold on
plot3(molecule_position_initial(:,1),molecule_position_initial(:,2),molecule_position_initial(:,3),'r.');
axis square;
xlim([-4, 4]); % è®¾ç½®Xè½´è????
ylim([-4, 4]); % è®¾ç½®Yè½´è????
zlim([-4, 4]); % è®¾ç½®Zè½´è????
title('molecule position initial'); % æ·»å????é¢?
% 生成一些随机数据  
data = randn(100,5);  
group = repmat(1:size(data,2), [size(data,1), 1]); % 创建与数据对应的组别标识  
  
% 创建箱线图  
boxplot(data, 'WhiskerStyle','line', 'Notch','off');  
hold on; % 保持当前图形以便添加更多内容  
  
% 使用scatter函数在箱线图上绘制数据点  
% 这里我们稍微调整了一下点的位置，以便它们不会完全覆盖箱线图  
scatter(group(:) + randn(size(data)) * 0.05 - 0.25, data(:), 'filled');  
  
% 设置坐标轴范围  
xlim([0.5 size(data,2) + 0.5]);  
ylim([-3 3]);  
  
% 添加标题和轴标签  
title('Box Plot with Overlaid Data Points')  
xlabel('Data Groups')  
ylabel('Data Values')  
  
% 添加图例  
legend('Boxplot', 'Data Points');  
  
% 关闭图形叠加模式  
hold off;
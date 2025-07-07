function [closest_index,closest_distance] = findclosestpoint(points,point_index)
% 生成一些随机的三维点  
% 选择一个目标点  
targetPoint = points(point_index,:);    
% 构造KD树  
kdtree = KDTreeSearcher(points);  
% 查询最近的2个点  
[index, distance] = knnsearch(kdtree, targetPoint,'k',2);
closest_index = index(end);
closest_distance = sum((targetPoint-points(closest_index,:)).^2);  
% closest_distance = distance(end);
end
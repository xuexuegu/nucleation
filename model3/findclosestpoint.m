function [closest_index,closest_distance] = findclosestpoint(points,point_index,r1,r2)
 
targetPoint = points(point_index,:);    
% ????KD??  
kdtree = KDTreeSearcher(points);  
% ?��?��??�???2�???  
[index, distance] = knnsearch(kdtree, targetPoint,'k',2);
closest_index = index(end);
% closest_distance = sum((targetPoint-points(closest_index,:)).^2);
closest_distance = calculateShortestPath(targetPoint, points(closest_index,:), r1, r2);
% closest_distance = distance(end);
end
classdef KDNode < handle  
    properties  
        point  
        splitDim  
        left  
        right  
    end  
    methods  
        function node = KDNode(point, splitDim)  
            node.point = point;  
            node.splitDim = splitDim;  
            node.left = [];  
            node.right = [];  
        end  
    end  
end  
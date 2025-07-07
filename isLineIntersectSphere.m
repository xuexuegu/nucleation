function isIntersect = isLineIntersectSphere(p1, p2,radius)  

    lineVec = p2 - p1; 
    lineMid = (p1 + p2) / 2; 
    distToCenter = norm(lineMid - [0,0,0]); % 
    halfLength = norm(lineVec) / 2;  

    if distToCenter < radius + halfLength  
        isIntersect = 1;  
    else  
        isIntersect = 0;  
    end  
end
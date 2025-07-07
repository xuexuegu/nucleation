function perpendicularVector = getRandomPerpendicularVector(lineVector)  
      
    % 生成两个随机的、非共线的向量  
    randomVector1 = rand(1, 3) - 0.5;  % 随机向量1  
    randomVector2 = rand(1, 3) - 0.5;  % 随机向量2  
      
    % 确保randomVector1和randomVector2不共线  
    while abs(dot(randomVector1, randomVector2)) > 0.99  
        randomVector2 = rand(1, 3) - 0.5;  
    end  
      
    % 使用叉积运算得到与直线向量垂直的向量  
    perpendicularVector1 = cross(lineVector, randomVector1);  
    perpendicularVector2 = cross(lineVector, randomVector2);  
      
    % 选择其中一个非零向量作为结果  
    if norm(perpendicularVector1) > norm(perpendicularVector2)  
        perpendicularVector = perpendicularVector1;  
    else  
        perpendicularVector = perpendicularVector2;  
    end  
      
    % 标准化向量  
    perpendicularVector = perpendicularVector / norm(perpendicularVector);  
end
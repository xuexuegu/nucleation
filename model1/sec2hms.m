% 辅助函数：将秒转换为时:分:秒格式  
function str = sec2hms(seconds)  
    h = floor(seconds / 3600);  
    m = floor(mod(seconds, 3600) / 60);  
    s = mod(seconds, 60);  
    str = sprintf('%02d:%02d:%02d', h, m, s);  
end  
  

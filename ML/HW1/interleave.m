function [v] = interleave(x,y)

    v = zeros(1,2*length(x));
    
    v(1:2:end);
    v(2:2:end);
    
end 
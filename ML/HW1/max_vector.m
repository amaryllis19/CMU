function [m] = max_vector(v)

    vlength = length(v);
    m = 0;
    p = inf;
    
    for i = 1:vlength
        if(v(i) > m)
            m = v(i);
        end;
        
        if(v(i) < p)
            p = v(i);
        end;    
    end;
    
    while()
    
end
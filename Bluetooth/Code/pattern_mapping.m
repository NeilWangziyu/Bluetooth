function bits_new = pattern_mapping(bits)
    
bits_new  = zeros(1,4*length(bits));
    
    for i = 1: length(bits)
        
        if bits(i) == 0
            
            bits_new(4*i-3) = 0; 
            bits_new(4*i-2) = 0; 
            bits_new(4*i-1) = 1; 
            bits_new(4*i) = 1; 
            
        else
            
            bits_new(4*i-3) = 1; 
            bits_new(4*i-2) = 1; 
            bits_new(4*i-1) = 0; 
            bits_new(4*i) = 0; 
            
        end
    end

end
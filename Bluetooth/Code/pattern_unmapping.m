function bits_new = pattern_unmapping(bits)
% Soft unmapping
    tem = mod(length(bits),4);
    if tem ~= 0 
        bits = [bits,  zeros(1, 4-tem)];
    end
    length_new = fix(length(bits)/4);
%     disp(length_new);
    
    bits_new  = zeros(1,length_new );
    
    a = [0 0 1 1];
    b = [1 1 0 0];
    j=1;
    
    for i = 1:4: length(bits)
        bits_seg= bits(i: i+3);
%         disp(bits_seg);
        dist0 = pdist2(bits_seg,a,'euclidean');
        dist1 = pdist2(bits_seg,b,'euclidean');
        
        if dist0 <= dist1
            bits_new(j) = 0;
        else
            bits_new(j) = 1;
        end
        j = j+1;
    end
    
end
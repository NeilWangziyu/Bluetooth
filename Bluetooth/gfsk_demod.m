function res = gfsk_demod(input,upSampRate)
%gfsk_demod 
        degree = angle(input);
        degree_unwrap = unwrap(degree);
        
        for n = 2:1:length(degree_unwrap)
            while abs(degree_unwrap(n)-degree_unwrap(n-1))>pi
                if degree_unwrap(n)-degree_unwrap(n-1)>pi
                    degree_unwrap(n) = degree_unwrap(n)-2*pi;
                elseif degree_unwrap(n)-degree_unwrap(n-1)< -pi
                    degree_unwrap(n) = degree_unwrap(n) + 2*pi;
                end
            end 
        end 
        
    if upSampRate == 3
        i = 1:upSampRate:length(degree_unwrap)-1;
        degree_unwrap = [0, degree_unwrap];
        demodBits = degree_unwrap(i+2) - degree_unwrap(i);      
    else
        % after comparsion, we found that upSampRate is better
        demodBit = diff([0, degree_unwrap]);
        demodBits = demodBit(1:upSampRate:length(demodBit));
    end
    res = demodBits;
end


function output = fec_enc(input,mode)
% output = testcnv_encd(g, k0, input) 
% (2,1,3) Convolution code
% input
% output length is 2*input length
    if mode == 2 || mode == 8
        trellis = poly2trellis(4,[17,15,13,11]);
        % 17:1111
        % 15:1101
        output = convenc(input,trellis);
    else 
    output = input;
    end
end


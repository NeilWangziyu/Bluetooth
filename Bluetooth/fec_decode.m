function output = fec_decode(demoBdBits, mode)
%fec_decode vitdec decode
    if mode == 1
% %   when mode == 1
        output = [];
        for i = (1:1:length(demoBdBits))
            if demoBdBits(i)<=0
                    output = [output,0];
                else
                    output = [output,1];
            end
        end
    else
% mode == 2 or 8
        if  mod(length(demoBdBits),4) ~= 0
            demoBdBits = [demoBdBits, zeros(1, 4-mod(length(demoBdBits),4))];
        end
        trellis = poly2trellis(4,[17,15,13,11]);
        % 17:1111
        % 15:1101
        qcode = quantiz(demoBdBits,[0.001,.1,.3,.5,.7,.9,.999]);
        output = vitdec(qcode,trellis,3,'trunc','soft',3);
%         output = vitdec(data,trellis,3,'trunc','hard');
    end



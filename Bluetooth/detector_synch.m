function startPt = detector_synch(bits, aa ,mode)
%   detector_synch  based on aa, find the payload for next step 
    [ma,i]=max(abs(xcorr(bits,aa)));
    la = length(aa);
    lb = length(bits);
    start = i - lb + la + 1;
    startPt_tem = bits(start:1:length(bits));
    
    if length(startPt_tem) < 800*mode
        % make sure that they can have 800 points for later process
        startPt = bits(length(bits)-800*mode:length(bits));
    else
        startPt = startPt_tem;
    end
end


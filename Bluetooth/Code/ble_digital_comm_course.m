
function BER = ble_digital_comm_course(mode, upSampRate)
    numBits = 400;
    aa = [1 0 0 0 1 1 1 0 1 0 0 0 1 0 0 1 1 0 1 1 1 1 1 0 1 1 0 1 0 1 1 0];
    % aa is used for detect payload
    
    t = -8:1/upSampRate:8;
    B = 0.5; T = 1; h = 0.5;
    snrDb1 = -4;
    snrDb2 = 12;
    snrDb = snrDb1:2:snrDb2;
    numSnrPt = length(snrDb);
    % numSnrPt:how many different snr that we test

    numchanLoop = 100;
    BER = zeros(1,numSnrPt);

for k = 1:numchanLoop
    payload = round(rand(1,numBits));
    payload_aa = [aa, payload];
    if mode == 1
        packet = payload_aa;
        aa_decode = aa;
    elseif mode == 2
        packet = fec_enc(payload_aa,mode);
        aa_decode = fec_enc(aa,mode);
    elseif mode == 8
        packet = fec_enc(payload_aa,mode);
        packet = pattern_mapping(packet);
        aa_decode = fec_enc(aa,mode);
        aa_decode = pattern_mapping(aa_decode);
    end
    
    %%% modul demodul parameter
    s = gfsk_modulation(upSampRate,packet,h,B,T,t);
    aa_synch = gfsk_modulation(upSampRate,aa_decode,h,B,T,t);

    %modulation,s is the signal after modulation
    nt = zeros(1,100);
    s = [nt,s];     %s add 100 0 and aa
    sigLen = length(s); %signal length
    %%% noise
    for mm = 1:numSnrPt
        noise = (randn(1,sigLen)+1j*randn(1,sigLen))*db2mag(-snrDb(mm))/sqrt(2)*sqrt(upSampRate);
        rcvSig = s+noise;   %really received noise
        
        startPt = detector_synch(rcvSig, aa_synch, mode);
        
        demodBits = gfsk_demod(startPt,upSampRate);
                
        if mode == 8
            ebcoded_sig = pattern_unmapping(demodBits);
        else
            ebcoded_sig = demodBits;
        end
       
        data = fec_decode(ebcoded_sig, mode);

        if length(data) ~= length(payload)
            if length(data) < length(payload)
                data = [data, zeros(1, length(payload)-length(data))];
            else
                data = data(1:length(payload));
            end
            BER(mm) = BER(mm)+sum(data~=payload)/numBits/numchanLoop;
        else
            BER(mm) = BER(mm)+sum(data~=payload)/numBits/numchanLoop;
        end
    end
end

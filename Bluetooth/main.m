clear; 
close all;
%%% coding decoding parameter
% mode:s = 2 or s = 8;
upSampRate = 2; % up sampling rate 3 or 2
mode1 = 1; % 1 or 2 or 8
mode2 = 2;
mode8 = 8;
BER1 = ble_digital_comm_course(mode1, upSampRate);
BER2 = ble_digital_comm_course(mode2, upSampRate);
BER8 = ble_digital_comm_course(mode8, upSampRate);

% plot BER for three mode
figure
semilogy((-4:2:12),BER1,'o-g');
hold on
semilogy((-4:2:12),BER2,'x-r');
hold on
semilogy((-4:2:12),BER8,'+-b');
legend('BER1','BER2','BER8')
grid on;

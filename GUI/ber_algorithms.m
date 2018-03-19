%QPSK

ber_target = 10^-5;
EbN0_range =0:0.001:30; %EbN0 in db
M = 4;


ber = berawgn(EbN0_range,'psk',M,'nondiff'); %returns the BER of uncoded QAM over an AWGN channel with coherent demodulation. The alphabet size, M, must be at least 4. 

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

% ber_verified = berawgn(EbN0,'qam',M);
% 
%semilogy(EbN0_range,ber)
%%
%4QAM
ber_target = 10^-3;
EbN0_range =0:0.001:30;
M = 4;


ber = berawgn(EbN0_range,'qam',M); %returns the BER of uncoded QAM over an AWGN channel with coherent demodulation. The alphabet size, M, must be at least 4. 

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

% ber_verified = berawgn(EbN0,'qam',M);
% 
% semilogy(EbN0_range,ber)


%qfunc(sqrt(2*79))
%function_test = 0.5*(qfuncinv(10^-3))^2

%%
%16QAM
ber_target = 10^-3;
EbN0_range =0:0.001:35;
M = 16;

ber = berawgn(EbN0_range,'qam',M);

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

%semilogy(EbN0_range,ber)

%%
%64QAM
ber_target = 10^-3;
EbN0_range =0:0.001:40;
M = 64;

ber = berawgn(EbN0_range,'qam',M);

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

% semilogy(EbN0_range,ber)
%%
%2FSK
ber_target = 10^-3;
EbN0_range =0:0.01:31;
M = 2;

ber = berawgn(EbN0_range,'fsk',M,'coherent');%returns the BER of orthogonal uncoded FSK modulation over an AWGN channel. coherence is either 'coherent' for coherent demodulation or 'noncoherent' for noncoherent demodulation. M must be no greater than 64 for 'noncoherent'

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

% semilogy(EbN0_range,ber);

%%
%QPSK - Rayleigh

ber_target = 10^-3;
EbN0_range =0:1:75; %EbN0 in db
M = 4;
divorder = 1;

ber = berfading(EbN0_range,'psk',M,divorder); %returns the BER of uncoded QAM over an AWGN channel with coherent demodulation. The alphabet size, M, must be at least 4. 

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

% ber_verified = berawgn(EbN0,'qam',M);
% 
% semilogy(EbN0_range,ber)
%%
%4QAM - Rayleigh
ber_target = 10^-8;
EbN0_range =0:1:75;
M = 4;
divorder = 1;

ber = berfading(EbN0_range,'qam',M,divorder); %returns the BER of uncoded QAM over an AWGN channel with coherent demodulation. The alphabet size, M, must be at least 4. 

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

% ber_verified = berawgn(EbN0,'qam',M);
% 
%  semilogy(EbN0_range,ber)


%qfunc(sqrt(2*79))
%function_test = 0.5*(qfuncinv(10^-3))^2

%%
%16QAM - Rayleigh
ber_target = 10^-8;
EbN0_range =0:1:80;
M = 16;
divorder = 1;

ber = berfading(EbN0_range,'qam',M,divorder);

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

% semilogy(EbN0_range,ber)

%%
%64QAM - Rayleigh
ber_target = 10^-8;
EbN0_range =0:1:85;
M = 64;
divorder = 1;

ber = berfading(EbN0_range,'qam',M,divorder);

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

% semilogy(EbN0_range,ber)
%%
%2FSK - Rayleigh
ber_target = 10^-8;
EbN0_range =0:1:80;
M = 2;
divorder = 1;

ber = berfading(EbN0_range,'fsk',M,divorder,'coherent');%returns the BER of orthogonal uncoded FSK modulation over an AWGN channel. coherence is either 'coherent' for coherent demodulation or 'noncoherent' for noncoherent demodulation. M must be no greater than 64 for 'noncoherent'

[~,i] = min(abs(ber-ber_target));
EbN0_dB = EbN0_range(i);
EbN0 =10^(EbN0_dB/10);

semilogy(EbN0_range,ber);
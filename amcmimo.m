function sigOut=amcmimo(sigIn,Nt,Nr,snr)
% AMCMIMO  Adds MIMO channnel and AWGN noise to signals according
%           value of Signal-to-noise ratio (SNR)
%
%   sigOut=amc_awgn(sigIn,snr) measures the power
%   of input signal sigIn and adds noise according
%   to snr (dB) to generate signals with noise sigOut
%
%   Copyright (C) 2013 Zhechen Zhu 
%   This file is part of Zhechen Zhu's AMC toolbox 0.1
%
%   Update (version no.): modification (editor)

% Determine the dimension of input signal data
N = length(sigIn);

% Generate the fading channel matrix

% Determine the number of transmitters and receivers
% Nt=hMIMOChan.NumTransmitAntennas;
% Nr=hMIMOChan.NumReceiveAntennas;
Nr=size(hMIMOChan,1);
Nt=size(hMIMOChan,2);

% Split the signal to spatial streams
channelInput = reshape (sigIn, [Nt N/Nt]).';

% Filter the signal using MIMO channel
% [channelOutput, pathGains] = step(hMIMOChan, channelInput);
channelOutput = (hMIMOChan*channelInput.').';

for i = 1:Nr
% Generate unscaled AWGN noise componentsv
noise(:,i) = randn(N/Nt,1) + j*randn(N/Nt,1);

% Calculate signal power
sigPower(:,i) = mean(abs(channelOutput(:,i)).^2);

% Calculate unscaled noise power
noisePower(:,i) = mean(abs(noise(:,i)).^2);

% Calculate scaling factor for noise components according to SNR
sigNoise(:,i) = sqrt(sigPower(:,i)./noisePower(:,i)).*(10^(-snr/20));

% Map the noise power scaling factor
sigOut(:,i) = channelOutput(:,i) + noise(:,i)*sigNoise(:,i);
end
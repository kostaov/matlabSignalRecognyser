function sigOut=amcawgn(sigIn,snr)
%AMCAWGN   Adds AWGN noise to signals according to Signal-to-noise ratio.
%
%   sigOut=amcawgn(sigIn,snr) measures the power
%   of input signal sigIn and adds noise according
%   to snr (dB) to generate signals with noise sigOut
%
%   Example: if sigIn = [1; j; -1; j; -j; -1] and snr = 10
%
%   sigOut=amcawgn(sigIn,snr)
%
%   sigOut =
%
%        1.2950 - 0.1861i
%       -0.0579 + 0.6392i
%       -1.3238 - 0.0961i
%        0.0932 + 1.3479i
%        0.0650 - 1.1780i
%       -0.7895 + 0.1439i
%
%   Copyright (C) 2014 Zhechen Zhu
%   This file is part of Zhechen Zhu's AMC toolbox 0.5
%
%   Update (version no.): modification (editor)
%   0.5:	The dimension of the input signal is no longer restricted (Zhechen Zhu)

% Determine the dimension of input signal data
N = size(sigIn);

% Generate unscaled AWGN noise components
noise = randn(N) + j*randn(N);

% Calculate signal power
sigPower = mean(abs(sigIn).^2);

% Calculate unscaled noise power
noisePower = mean(abs(noise).^2);

% Calculate scaling factor for noise components according to SNR
sigNoise = sqrt(sigPower./noisePower).*(10^(-snr/20));

% Map the noise power scaling factor
sigOut = sigIn + noise*sigNoise;

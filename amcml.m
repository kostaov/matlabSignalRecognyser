function [modulationDecision, likelihood]= amcml(sigIn,modulationPool,channelParameter)
%%AMCML   Classifies the modulation type  of the input signal using maximum
%%likelihood classifier
%   
%   result = amcml(sigIn,modulationPool,channelParameter) classifies the
%   modulation type of sigIn from a pool of modulation canddiates defined
%   by modulation pool. The channel state information channelParameter is
%   needed to complete the classification.
%
%   Copyright (C) 2013 Zhechen Zhu
%   This file is part of Zhechen Zhu's AMC toolbox 0.3
%
%   Update (version no.): modification (editor)

for iModulationCandidate = 1:numel(modulationPool)
    % Select modulation candidate
    modulationCandidate = modulationPool{iModulationCandidate};
    
    % Generated alphabet set/symbols for the modulation candidate
    symbol = getalphabet(modulationCandidate);
    
    % Calculate the noise variance from SNR
    sigma = sqrt(10^(-channelParameter(1)/10))/sqrt(2);
    
    % Evaluate the likelihood using AWGN noise model
    likelihood(iModulationCandidate) = likelihoodfunction(sigIn,symbol,sigma);
end

% Find the modulation candidate that provides the highest likelihood
[Y,iModulationDecision] = max(likelihood);
modulationDecision = modulationPool{iModulationDecision};

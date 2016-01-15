function [modulationDecision, testStat] = amcks(sigIn,modulationPool,channelParameter)
%%AMCKS   Classifies the modulation type  of the input signal using
%%Kolmogorov-Smirnov test classifier
%   
%   result = amcks(sigIn,modulationPool,channelParameter) classifies the
%   modulation type of sigIn from a pool of modulation canddiates defined
%   by modulation pool. The channel state information channelParameter is
%   needed to complete the classification.
%
%   Copyright (C) 2014 Zhechen Zhu
%   This file is part of Zhechen Zhu's AMC toolbox 0.4
%
%   Update (version no.): modification (editor)

% Construct emperical distribution on in-phase segment
signalI = sort(real(sigIn));
probI = hist(signalI,signalI);
empericalI = cumsum(probI)/length(sigIn);

% Construct emperical distribution on quadrature segment
signalQ = sort(imag(sigIn));
probQ = hist(signalQ,signalQ);
empericalQ = cumsum(probQ)/length(sigIn);

for iModulationCandidate = 1:numel(modulationPool)
    % Select modulation candidate
    modulationCandidate = modulationPool{iModulationCandidate};
    
    % Generated alphabet set/symbols for the modulation candidate
    symbol = getalphabet(modulationCandidate);
    
    symbolI = sort(real(symbol));
    symbolQ = sort(imag(symbol));
    
    % Calculate the noise variance from SNR
    sigma = sqrt(10^(-channelParameter(1)/10))/sqrt(2);
    
    % Calculate referene cumulative distribution at in-phase signal values    
    for iCentroid = 1:length(symbolI)
        cumdisI(iCentroid,:) = cdf('normal',signalI,symbolI(iCentroid),sigma);
    end
    cumdisI= sum(cumdisI)/length(symbolI);
    
    % Evaluate KS distance between in-phase signal and reference CDF
    dI(iModulationCandidate)=max(abs(empericalI-cumdisI));
    
    % Calculate referene cumulative distribution at in-phase signal values 
    for iCentroid = 1:length(symbolQ)
        cumdisQ(iCentroid,:) = cdf('normal',signalQ,symbolQ(iCentroid),sigma);
    end
    cumdisQ= sum(cumdisQ)/length(symbolQ);
    dQ(iModulationCandidate)=max(abs(empericalQ-cumdisQ));
    
    % Calcualte the KS test statistics for the modulation candidate
    testStat(iModulationCandidate) = mean([dI(iModulationCandidate) dQ(iModulationCandidate)]);
end

% Find the modulation hyphotheses with smallest test statistics
[Y,iModulationDecision] = min(testStat);
modulationDecision = modulationPool{iModulationDecision};

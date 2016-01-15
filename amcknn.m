function [modulationDecision, neighbours] = amcknn(modulationPool,testFeature,refFeature,label)
%AMCKNN   Modulation classifies using K-nearest neighbour classifier.
%   
%   [modulationDecision, neighbours] = amcknn(modulationPool,testFeature,refFeature,label)
%   classifies the modulation type of sigIn from a pool of modulation 
%   canddiates defined by modulation pool. The channel state information 
%   channelParameter is needed to complete the classification.
%
%   Copyright (C) 2014 Zhechen Zhu
%   This file is part of Zhechen Zhu's AMC toolbox 0.4
%
%   Update (version no.): modification (editor)

% % Feature extraction
% cumI = cumulant(real(sigIn));
% cumQ = cumulant(imag(sigIn));
% 
% % Create reference feature sets
% for iModulationCandidate = 1:numel(modulationPool)
%     
%     % Select modulation candidate
%     modulationCandidate = modulationPool{iModulationCandidate};
%     
%     % Generate reference signals and features
%     for iRef = 1:30
%         refSignal = genmodsig(modulationCandidate,length(sigIn));
%         refSignal=amcawgn(refSignal,channelParameter(1));
%         refCumI(iRef+(iModulationCandidate-1)*30,:) = cumulant(real(refSignal));
%         refCumQ(iRef+(iModulationCandidate-1)*30,:) = cumulant(imag(refSignal));
%     end
%     
%     % create label for the referenc feature sets
%     label((iModulationCandidate-1)*30+1:(iModulationCandidate-1)*30+30,1)=iModulationCandidate;
% end

% Measure distance from the test signal to reference signals
distance = sum(abs(bsxfun(@minus,testFeature,refFeature)),2);
decisionMatrix = [distance label];
decisionMatrix = sortrows(decisionMatrix);
decisionMatrix = decisionMatrix(1:11,:);

% Finding the mode of modulations in all neighbours
class = mode(decisionMatrix(:,2));
neighbours = hist(decisionMatrix(:,2),1:numel(modulationPool));
modulationDecision = modulationPool{class};

function featureCombo = amcgp(sigIn,modulationPool,channelParameter)
%AMCGP     Create a feature combination for AMC.
%   
%   featureCombo = amcgp(sigIn,modulationPool,channelParameter) selects a
%   set features from the raw features and creates a new feature as a
%   combination of selected raw features.The fitness evaluation is
%   implemented through a mini-classification method using k-nearest
%   neighbor classifier.
%
%   Copyright (C) 2014 Zhechen Zhu
%   This file is part of Zhechen Zhu's AMC toolbox 0.4
%
%   Update (version no.): modification (editor)

sampleNo=length(sigIn);

% Create reference feature sets
iModulationCandidate = 1;
for iModulationCandidate = 1:numel(modulationPool)
    modulationCandidate = modulationPool{iModulationCandidate};
    
    for iRef = 1:30
        refSignal = genmodsig(modulationCandidate,sampleNo);
        refSignal = amcawgn(refSignal,channelParameter); % AWGN channel;
        [refMomI(iRef+(iModulationCandidate-1)*30,:), refCumI(iRef+(iModulationCandidate-1)*30,:)] = hos(real(refSignal));
        [refMomQ(iRef+(iModulationCandidate-1)*30,:), refCumQ(iRef+(iModulationCandidate-1)*30,:)] = hos(imag(refSignal));
    end
    
    % create label for the referenc feature sets
    label((iModulationCandidate-1)*30+1:(iModulationCandidate-1)*30+30,1)=iModulationCandidate;
    
end

% Prepare GP training data
x=[refCumI refCumQ];
y=label;
filex=strcat(pwd,'\gpleab','\tempx.txt');
filey=strcat(pwd,'\gplab','\tempy.txt');
dlmwrite(filex,x,'delimiter','\t');
dlmwrite(filey,y,'delimiter','\t');

% Set GP parameters
p=resetparams;
p.calcfitness='knnfitness'; % Set fitness evaluation method
p=setfunctions(p,'times',2,'plus',2,'minus',2,'mylog',1,'sqrt',1,'sin',1,'cos',1,'asin',1,'acos',1,'tan',1,'tanh',1,'abs',1,'negator',1);
p=setoperators(p,'crossover',2,2,'mutation',1,1);
p.operatorprobstype='fixed';
p.initialprobstype='fixed';
p.initialfixedprobs=[0.8 0.2];
p.minprob=0;
p.datafilex=filex;
p.datafiley=filey;
p.usetestdata=0;
p.calcdiversity={'uniquegen'};
p.calccomplexity=1;

% Screen & Graphic Output
p.output='silent';
% p.graphics={'plotfitness','plotdiversity','plotcomplexity','plotoperators'};

% Run GP program
if exit gplab
    [v,b]=gplab(100,25,p);
else
    fprintf('The GPLAB toolbox is not installed. Please visit http://gplab.sourceforge.net/ to install the toolbox.')
end
featureCombo = b.str;
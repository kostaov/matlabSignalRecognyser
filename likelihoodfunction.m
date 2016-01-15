function likelihood = likelihoodfunction(signal,alphabet,sigma)
%%LIKELIHOODFUNCTION   Calculate the log likelihood of signal belonging
%   to a set of bivariate normal distributions with specified
%   alphabet(means) and sigma (standard deviation)
%
%   likelihood = likelihoodfunction(sample,alphabet,sigma) calculates
%   the log likelihood of given signal samples belonging to the
%   distributions defined by the modulation alphabet and noise pwoer given
%   by sigma
%
%   Example: Calculate the log likelihood of signal = [1+i, 1-i, -1-i,
%   -1+i] to belong to the bivariate normal distribution with alphabet =
%   [2+2i, -2+2i, 2-2i, -2-2i] and sigma = 1
%
%   likelihood = likelihoodfunction(signal,alphabet,sigma)
%
%   likelihood =
%
%       0.0152
%
%   See also generate4qamsignal, generate16qamsignal
%
%   Copyright (C) 2013 Zhechen Zhu
%   This file is part of Zhechen Zhu's AMC toolbox 0.2
%
%   Update (version no.): modification (editor)

for iSignal = 1:numel(signal)
    for iAlphabet = 1:numel(alphabet)
        iLikelihood(iAlphabet) = exp(-(abs(signal(iSignal)-alphabet(iAlphabet)))^2/2/sigma^2)/(2*pi*sigma^2);
    end
    likelihood(iSignal) = mean(iLikelihood);
end

likelihood = sum(log(likelihood));

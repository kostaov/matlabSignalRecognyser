function sigOut = genmodsig(modulationType,sampleNo)
%%GENMODSIG   Generate i.i.d modulated signal samples with unit power
%
%   sigOut = genmodsig(modulationType,sampleNo) returns a i.i.d. sequence
%   modulated using modulationType and length defined by sampleNo.
%   Acceptable modulationType include:'2pam', '4pam', '8pam', '2psk',
%   '4psk', '8psk', '4qam', '16qam', '64qam'
%
%   Example: Generation 4x1 array of BPSK/2-PSK modulated signals
%
%   sigOut = genmodsig('2psk',4)
%
%   sigOut =
%
%       -1
%       -1
%        1
%       -1
%
%   See also amcawgn, amcfading, amcnonguassian
%
%   Copyright (C) 2014 Zhechen Zhu
%   This file is part of Zhechen Zhu's AMC toolbox 0.4
%
%   Update (version no.): modification (editor)

% Create basic mapping of signal symbols
symbolMap = getsymbol(modulationType);

% Create uniform random index of signal samples
symbol = fix(rand(sampleNo,1)*size(symbolMap,1)) + 1;

% Map the signal samples to symbols
sigOut = symbolMap(symbol);

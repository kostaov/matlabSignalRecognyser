function cumulants = cumulant(sigIn)
%%CUMULANT   Calculates set of high order cumulant from the input signal
%
%   cumulants = cumulant(sigIn) returns an array of high order cumulants
%   from the signal sigIn
%
%   EsigInample: if sigIn = [1 -1 2 -4 -3 3]
%
%   alphabet = getalphabet('4qam')
%
%    cumulants =
%
%      Columns 1 through 6
%
%       -1.4961   -1.4961   -1.4961   10.0026   10.0026   10.0026
%
%      Column 7
%
%       10.0026
%
%   Copyright (C) 2013 Zhechen Zhu
%   This file is part of Zhechen Zhu's AMC toolbosigIn 0.3
%
%   Update (version no.): modification (editor)

% Normalize signal
sigIn = sigIn(:)-mean(sigIn(:));
sigIn = sigIn./std(sigIn,1);

% Determine signal length
N = length(sigIn);

% Calculate signal moments

%M20 = E(sigIn,sigIn),
M20 = mean(sigIn.^2);
%M21 = E(sigIn,sigIn*),
M21 = mean(sigIn.*conj(sigIn));
%M22 = E(sigIn*,sigIn*),
%M22 = M20;
M22 = mean(conj(sigIn).^2);
%M40 = E(sigIn,sigIn,sigIn,sigIn),
M40 = mean(sigIn.^4);
%M41 = E(sigIn,sigIn,sigIn,sigIn*),
M41 = mean(sigIn.^3.*conj(sigIn));
%M42 = E(sigIn,sigIn,sigIn*,sigIn*),
M42 = mean(sigIn.^2.*conj(sigIn).^2);
%M43 = E(sigIn,sigIn*,sigIn*,sigIn*),
M43 = mean(sigIn.*conj(sigIn).^3);
%M60 = E(sigIn,sigIn,sigIn,sigIn,sigIn,sigIn),
M60 = mean(sigIn.^6);
%M61 = E(sigIn,sigIn,sigIn,sigIn,sigIn,sigIn*),
M61 = mean(sigIn.^5.*conj(sigIn));
%M62 = E(sigIn,sigIn,sigIn,sigIn,sigIn*,sigIn*), and
M62 = mean(sigIn.^4.*conj(sigIn).^2);
%M63 = E(sigIn,sigIn,sigIn,sigIn*,sigIn*,sigIn*).
M63 = mean(sigIn.^3.*conj(sigIn).^3);

 

% Also please use the following NOW

C40 = M40 - 3*M20^2;

C41 = M41 - 3*M20*M21;

C42 = M42 - abs(M20)^2 - 2*M21^2;

C60 = M60 - 15*M20*M40 + 30*M20^3;

C61 = M61 - 5*M21*M40 - 10*M20*M41 + 30*M20^2*M21; 

C62 = M62 - 6*M20*M42 - 8*M21*M41 - M22*M40 + 6*M20^2*M22 + 24*M21^2*M20;

C63 = M63 - 9*M21*M42 + 12*M21^3 - 3*M20*M43 - 3*M22*M41 + 18*M20*M21*M22; 

% C21 = mean(abs(sigIn).^2);
% C60 = M60 - 15*M20*M40 + 30*M20^3;
% C61 = M61 - 5*M21*M40;
% C62 = M62;
% C63 = M63- 9*M21*M42 + 12*M21^3;

M = [M20 M21 M22 M40 M41 M42 M43 M60 M61 M62 M63];
cumulants = [C40 C41 C42 C60 C61 C62 C63];


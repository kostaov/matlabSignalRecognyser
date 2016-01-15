function [M, C] = hos(X)
% function to calculate Stats feature set
% of Swami
%
X = X(:)-mean(X(:));
X = X./std(X,1);
N = length(X);

%M20 = E(X,X),
M20 = mean(X.^2);
%M21 = E(X,X*),
M21 = mean(X.*conj(X));
%M22 = E(X*,X*),
%M22 = M20;
M22 = mean(conj(X).^2);
%M40 = E(X,X,X,X),
M40 = mean(X.^4);
%M41 = E(X,X,X,X*),
M41 = mean(X.^3.*conj(X));
%M42 = E(X,X,X*,X*),
M42 = mean(X.^2.*conj(X).^2);
%M43 = E(X,X*,X*,X*),
M43 = mean(X.*conj(X).^3);
%M60 = E(X,X,X,X,X,X),
M60 = mean(X.^6);
%M61 = E(X,X,X,X,X,X*),
M61 = mean(X.^5.*conj(X));
%M62 = E(X,X,X,X,X*,X*), and
M62 = mean(X.^4.*conj(X).^2);
%M63 = E(X,X,X,X*,X*,X*).
M63 = mean(X.^3.*conj(X).^3);

 

% Also please use the following NOW

C40 = M40 - 3*M20^2;

C41 = M41 - 3*M20*M21;

C42 = M42 - abs(M20)^2 - 2*M21^2;

C60 = M60 - 15*M20*M40 + 30*M20^3;

C61 = M61 - 5*M21*M40 - 10*M20*M41 + 30*M20^2*M21; 

C62 = M62 - 6*M20*M42 - 8*M21*M41 - M22*M40 + 6*M20^2*M22 + 24*M21^2*M20;

C63 = M63 - 9*M21*M42 + 12*M21^3 - 3*M20*M43 - 3*M22*M41 + 18*M20*M21*M22; 

% C21 = mean(abs(X).^2);
% C60 = M60 - 15*M20*M40 + 30*M20^3;
% C61 = M61 - 5*M21*M40;
% C62 = M62;
% C63 = M63- 9*M21*M42 + 12*M21^3;

M = [M20 M21 M22 M40 M41 M42 M43 M60 M61 M62 M63];
C = [C40 C41 C42 C60 C61 C62 C63];

% features = [M; C]';


function [A_k] = interval_DFT_extension(signal,k)
%% Interval DFT extension (rigorous algorithm)
%
% Author:
% Marco Behrendt
% Institute for Risk and Reliability, Leibniz Universität Hannover
% behrendt@irz.uni-hannover.de
% https://github.com/marcobehrendt
%
% Behrendt et al. (2022): Projecting interval uncertainty through the 
% discrete Fourier transform: an application to time signals with poor 
% precision, Mechanical Systems and Signal Processing, 172, Article 108920, 
% DOI: 10.1016/j.ymssp.2022.108920.
%
% Date: 17/03/2022

% length of interval signal
N = length(signal);

% interval extension of the DFT (Eq. (7)) for frequency k
z_k = [0;0];
for n = 1:N
    z_k = z_k + interval_multiplication(signal(:,n),exp(-1i*2*pi*(n-1)*k/N));
end

% distances of the vertices of the bounding box to the origin
d_ll = abs(real(z_k(1)) + 1i * imag(z_k(1)));
d_lh = abs(real(z_k(1)) + 1i * imag(z_k(2)));
d_hl = abs(real(z_k(2)) + 1i * imag(z_k(1)));
d_hh = abs(real(z_k(2)) + 1i * imag(z_k(2)));

x = [real(z_k(1));real(z_k(1));real(z_k(2));real(z_k(2))];
y = [imag(z_k(1));imag(z_k(2));imag(z_k(1));imag(z_k(2))];

% determining the convex hull of all points
chull_idx = convhull(x,y);
x = x(chull_idx);
y = y(chull_idx);

% get maximum distance to origin
A_k_max = max([d_ll d_lh d_hl d_hh]);

% get minimum distance to origin depending on different cases
if inpolygon(0,0,x,y)
    A_k_min = 0;
elseif real(z_k(1)) <= 0 && 0 <= real(z_k(2))
    A_k_min = min(abs(imag(z_k(1))), abs(imag(z_k(2))));
elseif imag(z_k(1)) <= 0 && 0 <= imag(z_k(2))
    A_k_min = min(abs(real(z_k(1))), abs(real(z_k(2))));
else
    A_k_min = min([d_ll d_lh d_hl d_hh]);
end

% determine lower and upper bound
A_k = [A_k_min; A_k_max];

end


function c = interval_multiplication(signal,expon)
% function that determines the interval multiplication for complex numbers

c_real_min = min([signal(1) * real(expon); signal(2) * real(expon)]);
c_real_max = max([signal(1) * real(expon); signal(2) * real(expon)]);

c_imag_min = min([signal(1) * imag(expon); signal(2) * imag(expon)]);
c_imag_max = max([signal(1) * imag(expon); signal(2) * imag(expon)]);

c = [c_real_min + 1i * c_imag_min; c_real_max + 1i * c_imag_max];

end


function A_k = interval_DFT_selective(signal,k)
%% Interval DFT algorithm (selective algorithm)
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

% compute first two vertices
v = [exp(-1i*2*pi*0*k/N) * signal(1,1); exp(-1i*2*pi*0*k/N) * signal(2,1)];

% initialise convex hull
chull = v;

for n=2:N
    % compute subsequent vertices
    v = [exp(-1i*2*pi*(n-1)*k/N)*signal(1,n); exp(-1i*2*pi*(n-1)*k/N)*signal(2,n)];

    % add the two vertices v separately to the list chull to get a list of new endpoints
    ep = [v(1) + chull; v(2) + chull];

    % get convex hull of ep in R^2 with real and imaginary components as coordinates
    ep = unique(ep);
    ep_real = real(ep);
    ep_imag = imag(ep);
    try
        % generate convex hull of all points in this iteration
        chull_idx = convhull(ep_real,ep_imag);
        chull = ep(chull_idx,:);
    catch
        % if not possible to generate convex hull (e.g. if not enough
        % unique points specified), pass all points to the next iteration
        chull = ep;
    end
end

% check if the coordinate origin is contained in the convex hull
if inpolygon(0,0,real(chull),imag(chull))
    % if yes: return 0 for lower bound
    A_k = [0;max(abs(chull))]; 
else
    % if no: return minimal distance from origin to convex hull as lower bound
    A_k = [min(abs(chull)); max(abs(chull))]; 
end

end

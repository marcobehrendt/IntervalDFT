function p = plot_intervalPSD(w, intervalspectrum, color)
% Function for visualising the upper and lower bound of the imprecise
% stationary power spectrum
%
% INPUT:
%       - w:                Frequency vector
%       - intervalspectrum: Upper and lower bound of the spectrum
%       - color:            Color of plot hexadecimal
%
% OUTPUT:
%       - p:                Plot object with specifications
%
% Author:
% Marco Behrendt
% Institute for Risk and Reliability, Leibniz Universität Hannover
% behrendt@irz.uni-hannover.de
% https://github.com/marcobehrendt
%
% Date: 17/03/2022


if size(w,1) == 1
    x = [w fliplr(w)];
else
    x = [w; flipud(w)];
end
y = [intervalspectrum(1,:) fliplr(intervalspectrum(end, :))];

try
    face_col_rgb = sscanf(color,'%2x%2x%2x',[1 3])/255;
    p = fill(x, y, face_col_rgb);
    p.EdgeColor = face_col_rgb;
catch
    warning('Unexpected color type. No changes.')

    face_col_rgb = 'b';
    p = fill(x, y, face_col_rgb);
    p.EdgeColor = face_col_rgb;
end

grid on;
grid_col_rgb = sscanf('b0b0b0','%2x%2x%2x',[1 3])/255;
set(gca, 'GridColor', grid_col_rgb)
set(gca, 'GridAlpha', 1)
set(gca, 'Layer', 'top')

end


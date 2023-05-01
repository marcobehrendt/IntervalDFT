function plot_intervalsignal(t, x)
% Function to visualise the upper and lower bounds of the (partially) 
% intervalised signal 
%
% INPUT:
%       - t: time vector
%       - x: data points
%
% Marco Behrendt
% Institute for Risk and Reliability, Leibniz Universität Hannover
% behrendt@irz.uni-hannover.de
% https://github.com/marcobehrendt
%
% Date: 17/03/2022

p_f = fill([t fliplr(t)],[x(1,:) fliplr(x(2,:))],[187 213 232]./255);
p_f.EdgeColor = [187 213 232]./255;
plot(t, x(2,:), 'Color', [245 118 28]./255, 'LineWidth', 1);
plot(t, x(1,:), 'Color', [31 119 180]./255, 'LineWidth', 1);

grid on;
grid_col_rgb = sscanf('b0b0b0','%2x%2x%2x',[1 3])/255;
set(gca, 'GridColor', grid_col_rgb)
set(gca, 'GridAlpha', 1)

end


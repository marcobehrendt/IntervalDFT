close all; clear; clc

% load signal
load("signal_64.mat")
Nt = length(signal);

figure; hold on; grid on;
plot(t, signal)
xlim([t(1) t(end)])
xlabel('Time (s)')
ylabel('Wave height (m)')
legend('Signal without missing data')

% randomly generate missing data
n_md = 10; % number of missig data
signal_md = signal;
md_pos = randperm(Nt,n_md); % randomly selected positions of missing data
signal_md(md_pos) = NaN;

figure; hold on; grid on;
plot(t, signal_md)
xlim([t(1) t(end)])
xlabel('Time (s)')
ylabel('Wave height (m)')
legend('Signal with missing data')

% reconstruct missing data by adding interval uncertainty x0 to true data point
x0 = 0.5;
reconstructed_signal = [signal; signal];
reconstructed_signal(:,md_pos) = [reconstructed_signal(1,md_pos)-x0; reconstructed_signal(2,md_pos)+x0];

figure; hold on; grid on;
plot_intervalsignal(t, reconstructed_signal)
xlim([t(1) t(end)])
xlabel('Time (s)')
ylabel('Wave height (m)')

% Target PSD for comparison
S_target = 0;
k = 0:Nw-1;
for n=1:Nt
    S_target = S_target + exp(-1i*2*pi*(n-1)*k/Nt)*signal(n);
end
S_target = abs(S_target).^2.*dt^2/T/(2*pi); % periodogram to estimate the PSD of a signal

% interval spectrum of reconstructed signal
S_ext = zeros(2,Nt/2);
S_sel = zeros(2,Nt/2);
for freq = 1:Nw-1 % due to numerical issues: set first frequency to zero
    S_ext(:,freq+1) = interval_DFT_extension(reconstructed_signal,freq);
    S_sel(:,freq+1) = interval_DFT_selective(reconstructed_signal,freq);
end
S_ext = abs(S_ext).^2.*dt^2/T/(2*pi); % periodogram 
S_sel = abs(S_sel).^2.*dt^2/T/(2*pi); % periodogram 


%% plot results
figure; hold on;
plot_intervalPSD(w, S_ext, 'c1d4f8');
plot_intervalPSD(w, S_sel, 'e67e63');
plot(w, S_target, 'LineWidth', 1, 'Color', [0 0.45 0.74])
xlim([w(1) w(end)])
xlabel('Frequency (rad/s)')
ylabel('Power spectral density (m^2s)')
legend('Interval extension', 'Selective algorithm', 'Target PSD')

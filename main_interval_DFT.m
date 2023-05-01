close all; clear; clc

%% signal

% load signal
load("signal_64.mat")
figure; hold on; grid on;
plot(t, signal)
xlabel('Time (s)')
ylabel('Wave height (m)')

% intervalise signal by adding interval uncertainty x0 to true data point
x0 = 0.2;
interval_signal = [signal-x0; signal+x0];

figure; hold on; grid on;
plot_intervalsignal(t, interval_signal)
xlabel('Time (s)')
ylabel('Wave height (m)')


%% PSD

% Target PSD for comparison
S_target = 0;
k = 0:Nw-1;
for n=1:Nt
    S_target = S_target + exp(-1i*2*pi*(n-1)*k/Nt)*signal(n);
end
S_target = abs(S_target).^2.*dt^2/T/(2*pi); % periodogram

% interval spectrum of the interval signal
S_ext = zeros(2,Nt/2);
S_sel = zeros(2,Nt/2);
for freq = 1:Nw-1 % due to numerical issues: set first frequency to zero
    S_ext(:,freq+1) = interval_DFT_extension(interval_signal,freq);
    S_sel(:,freq+1) = interval_DFT_selective(interval_signal,freq);
end
S_ext = abs(S_ext).^2.*dt^2/T/(2*pi); % periodogram
S_sel = abs(S_sel).^2.*dt^2/T/(2*pi); % periodogram

%% plot results
figure; hold on;
plot_intervalPSD(w, S_ext, 'c1d4f8');
plot_intervalPSD(w, S_sel, 'e67e63');
plot(w, S_target, 'LineWidth', 1, 'Color', [0 0.45 0.74])
xlabel('Frequency (rad/s)')
ylabel('Power spectral density (m^2s)')
legend('Interval extension', 'Selective algorithm', 'Target PSD')

clear all;
close all;

% Get data for star
data = importdata('u1.txt');
days = data(:, 1);
vel = data(:, 2);
days = days - days(1);

% Just show data
figure;
plot(days, vel, '*');
title('Measured velocity of star 47 UMa');
xlabel('Days');
ylabel('Radial velocity (m/s)');

% Resample and show interpolated data
figure;
resampled_vel = resample(vel, days, 1);
plot(days, vel, '*');
hold on;
plot(linspace(0, days(end), length(resampled_vel)), resampled_vel);
title('Measured radial velocity of star 47 UMa');
legend('Measured values', 'Interpolated curve');
xlabel('Days');
ylabel('Radial velocity (m/s)');
hold off;

% Put window around data and do FFT and show FFT plot
figure;
windowed_resampled_vel = resampled_vel.*hanning(length(resampled_vel));
transformed = fft(resampled_vel);
plot(abs(transformed));
axis([0, 50, 0, 10^5]);
title('FFT of interpolated data, with hanning window');
xlabel('Frequency');
ylabel('Power');

% Find highest peak and calculate real period of assumed planet.
[peaks, peak_freqs] = findpeaks(abs(transformed), 'SortStr', 'descend');
Fs = 1./(days(end)/length(windowed_resampled_vel));
period = 1./(Fs.*((peak_freqs(1)-1)./length(windowed_resampled_vel)));
disp(['Period of closest planet: ' num2str(period, 4) ' days']);
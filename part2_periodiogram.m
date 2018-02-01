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
title('Measured radial velocity of star 47 UMa');
xlabel('Days');
ylabel('Radial velocity (m/s)');

% Plot Lomb-Scargle periodogram
vel = vel.*hanning(length(vel));
[power, frequncy] = plomb(vel, days);
plot(1./frequncy, power);
axis([0 8000 0 2.5*10^6]);
title('Lomb-Scargle periodogram of 47 UMa radial velocity');
xlabel('Period (days)');
ylabel('Power');

% Find highest peak
[peaks, peak_freqs] = findpeaks(power, 'SortStr', 'descend');
disp(['Period of closest planet: ' num2str(1./frequncy(peak_freqs(1)), 5) ' days']);
clear all;
close all;

% I know the plomb of the largest dataset has 430 points, so lets use that.
N = 430;
total_power = zeros(N, 1);
total_frequency = zeros(N, 1);
show_all_plots = 1;

for i = 1:9
    % Import one of nine datasets
    data = importdata(['u' num2str(i) '.txt']);
    days = data(:, 1);
    vel = data(:, 2);
    days = days - days(1);
    [power, frequency] = plomb(vel, days);
    
    if show_all_plots == 1
        figure;
        plot(1./frequency, power);
        peaks = findpeaks(power, 'SortStr', 'descend');
        axis([0, 8000, 0, peaks(1) + peaks(1) * 0.1]);
    end
    
    % Add power of plomb into total power, padding with zeros to match length
    total_power = total_power + [power; zeros(N - length(power), 1)];
    
    % Hack for getting frequency once (I know first dataset is longest)
    if i == 1 
        total_frequency = frequency;
    end
end

% Average power (not really necessary for finding peaks, but whatever)
total_power = total_power ./ 9;

% Plot average plomb diagram, by period.
figure;
plot(1./total_frequency, total_power);
xlabel('Period (days)');
ylabel('Power');
title('Average of 9 different Lomb-Scargle periodograms for 47 UMa');

% Zoom in on interesting part
axis([0, 8000, 0, 1.5*10^6]);

% Find and show largest two peak, which are assumed to be planets.
[peaks, peak_freqs] = findpeaks(total_power, 'SortStr', 'descend');
disp(['Period of two closest planets: ' num2str(1./total_frequency(peak_freqs(2)), 4) ' and ' num2str(1./total_frequency(peak_freqs(1)), 4) ' days']);
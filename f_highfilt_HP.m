% f_highfilt.m

% This function high pass filters the data and demeans it and then plots
% the water surface elevation of the original data and the filtered data

% Input values:
% n = water surface elevation record with noise removed if necessary
% Fs = sampling frequency (Hz)
% Fc = cutoff frequency

% Output values:
% filt_data = demeaned and high pass filtered water surface elevation
% record
% Also displays figure with water surface elevation of original record and
% filt_data record

function [filt_data]=f_highfilt_HP(n,Fs,Fc)

% Define length of filter
filt_length=Fc^-1*Fs;

% Apply filter
filt_data=filtfilt(ones(round(filt_length),1),round(filt_length),n);
filt_data=n-filt_data;

% Create time array at sampling frequency
L=length(n);
S=1/Fs;
orig_time=(0:S:((L-1)*S));

% Plot original and filtered surface elevation
figure
subplot(2,1,1);
plot(orig_time,n);
ylabel('Surface elevation (m)');
axis tight
subplot(2,1,2);
plot(orig_time,filt_data);
title('Filtered data');
ylabel('Surface elevation (m)');
xlabel('Time (s)');
hold on
% Plot zero water surface elevation line
plot(0:(L/Fs),0,'r');
hold off
axis tight
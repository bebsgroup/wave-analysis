% f_specplot.m

% This function calculates the frequency spectrum of the water surface
% elevation both unsmoothed and smoothed and displays them in a figure

% Input values:
% n = original water surface elevation record with noise removed if
% necessary
% Fs = sampling frequency (Hz)

% Output values:
% No output arrays
% Displays figure of frequency spectrum of data - both smoothed and
% unsmoothed

function [P1 f1 P2 f2]=f_specplot_HP(n,Fs)

L=length(n);

[P1 f1]=psd(n,L,Fs,L,0,'linear');
[P2 f2]=psd(n,L,Fs,round(L/4),round(L/8),'linear');
figure
subplot(2,1,1);
plot(f1,P1);
v=axis;
v(1,1:2)=[0 0.5];
axis(v);
title('Frequency spectrum - unsmoothed');
ylabel('Spectral density (m^2s)');
clear v
subplot(2,1,2);
plot(f2,P2);
v=axis;
v(1,1:2)=[0 0.5];
axis(v);
title('Frequency spectrum - smoothed (Segment length 1/4, 50% overlap)');
ylabel('Spectral density (m^2s)');
xlabel('Frequency (Hz)');
clear v
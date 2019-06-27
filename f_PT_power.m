function out=f_PT_power(x,dt,h)
%function out=PT_power(x,dt,h)
% Input data:
%   x = vector with input time series;
%   dt = time sampling intervals;
%   h = use Hanning window, default 0 (no)
%
% This is a function to calculate the power spectrum px
% from a time series x.  It outputs both freq and power
% arrays.
%
%Created by Brad Morris
%Friday 28 February 2003
%Last modified Wednesday 25 July 2012

if nargin<3
    h=0;
end

% Evaluate the size of the vector
n = length(x);
% Detrend the time series and keep it on vector xd
xd = detrend(x);

if h
    % Apply a Hanning window in the time domain
    xd = xd .* hanning(n);
end

% Calculate the Fast Fourier Transform
xn = fft(xd,n);

if h
    %  Important: in the case that you apply the Hanning window,
    %             it is important to multiply the Fourier
    %             coefficients xn by sqrt(8/3).
    xn = xn .* sqrt(8/3);
end

% Calculate the two sided Power Spectrum
pxx = dt*(xn.*conj(xn))/n;
%Calculate the two sided amplitude spectrum
paa = sqrt(xn.*conj(xn))/n;
pxx = dt*(xn.*conj(xn))/n;
%
%Calculate one sided spectrum
nf=fix((n/2)+1);
px=2.0*pxx(1:nf); %power spectrum
pa=2.0*paa(1:nf); %amplitude spectrum
%
% define the frequency vector
f=(0:1/(n*dt):1/(2*dt))';
%f = Fs*(0:(L/2))/L

out.f=f;
out.px=px;
out.pa=pa;

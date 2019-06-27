% f_ursell.m

% This function calculates the Ursell number for each wave in the record

% Input values:
% heights = wave heights = peaks + abs(troughs)
% peaks = magnitude of wave peaks relative to mean water surface elevation
% period = wave period in seconds
% n = original water surface elevation record with noise removed if
% necessary

% Output values:
% ur_num = ursell number for each wave in the record
% c = wave speed calculated using solitary wave theory
% wlength = wavelength calculated using solitary wave theory and L=CT

function [ur_num wlength c]=f_ursell_HP(heights,peaks,period,n);

% Calculates wave speed based on solitary wave theory where h = mean water
% depth over the whole time series
c=sqrt((peaks+mean(n))./9.81);

% Calculates wavelength
wlength=c.*period;

% Calculates ursell number
ur_num=(heights.*(wlength.^2))./(mean(n).^3);


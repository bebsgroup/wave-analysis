% f_wavearea.m

% This function calculates the area under the wave shape above the zero
% crossing line for all the waves in the water surface elevation record

% Input values:
% dcrossings = row numbers in filt_data array where downcrossings occur
% ucrossings = row numbers in filt_data array where upcrossings occur
% filt_data = water surface elevation record that has been high pass
% filtered, noise filtered and demeaned
% Fs = sampling frequency (Hz)

% Output values:
% wave_area = area under the waveform for each wave in the record

function [wave_area]=f_wavearea_HP(dcrossings,ucrossings,filt_data,Fs);

for j=1:(length(dcrossings(:,1))-1);
    wave_area(j,1)=sum(filt_data(ucrossings(j,1):dcrossings(j+1,1),1))/Fs;

end

clear j
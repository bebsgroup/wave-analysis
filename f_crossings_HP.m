% f_crossings.m

% This function calculates the upcrossings and downcrossings of a time
% series of water surface elevations and creates two arrays with the row
% numbers where the upcrossings and downcrossings occur

% Input values:
% filt_data = water surface elevation record that has been high pass
% filtered, noise filtered and demeaned

% Output values:
% dcrossings = row numbers in filt_data array where downcrossings occur
% ucrossings = row numbers in filt_data array where upcrossings occur

function [dcrossings ucrossings]=f_crossings_HP(filt_data)

% Determine row nubers of downcrossings
for j=1:length(filt_data)-1
    if filt_data(j,1)>0 & filt_data(j+1,1)<0
        dcrossings(j,1)=j;
    else dcrossings(j,1)=NaN;
    end
end
dcrossings(isnan(dcrossings))=[];% Removes NaNs from crossings array

% Determine row numbers of upcrossings
kk=dcrossings(1,1);
for k=kk:length(filt_data)-1
    if filt_data(k,1)<0 & filt_data(k+1,1)>0
        ucrossings(k-kk+1,1)=k;
    else ucrossings(k-kk+1,1)=NaN;
    end
end
ucrossings(isnan(ucrossings))=[]; % Removes NaNs from crossings array

clear j k kk

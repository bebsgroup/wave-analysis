% PT_tool_final

%Created by Brad Morris
%Wednesday 22 March 2017
%Last modified 22.02.2018 (AVC)

% clear all
% close all
% 
% data_raw=f_loadCSVraw;
% data_raw=mat_load;


%% Reshape data 

% Reshape data into 30 minute runs
% Comment from reviewer "As a general rule, your segment should be minimum
% five times the lowest period you are looking at, i.e. 5 x 300s = 25 min.
% Conveniently, you could use a cutoff frequency of 0.004 Hz with segments
% of 20 min, or even better 30 min. In comparison, Péquignet et al, 2011 
% uses 2 hours segments"

wave.info=data_raw.info;
rl=30;%min
dt=0.25;%sec
bl=(rl/dt)*60;
nbl=floor(size(data_raw.time,1)/bl);

data.time=reshape(data_raw.time(1:nbl*bl),bl,nbl);
data.press=reshape(data_raw.press(1:nbl*bl),bl,nbl);
data.segment=rl; %length of segments after reshaping data

% Mean water level for each run
wave.mpress=mean(data.press,1);

%% Sea swell spectral wave parameters

% Calculate spectral wave parameters
% This calculates the total spectrum of each data segment (PT_power) AND the wave
% parameters for the sea-swell band (f_PT_waves_spectral)

for k=1:nbl
    wave.time(k)=data.time(1,k);
    p=f_PT_power(data.press(:,k),dt,1);
    
    out=f_PT_waves_spectral(p.px,p.f,dt);
    
    wave.Hm0(k)=out.hs;
    wave.Hrms(k)=out.hrms;
    wave.Hmax(k)=out.hmax;
    wave.Tm02(k)=out.tm02;
    wave.Tm01(k)=out.tm01;
    wave.Tpeak(k)=out.tpeak;
    wave.eps(k)=out.eps;
    wave.s(k,:)=p.px;  %spectrum
    wave.fspec(k,:)=p.f;
end

%% From Hannah

Fs=4; % Set sampling frequency Fs
n=data.press; %n = water surface elevation record with noise removed if necessary
    
    % Find cut-off frequency
    
    plot(wave.fspec,wave.s)
    [x,y]=ginput(1);
    Fc=x;

    % Noise filter

    bnoise=fir1(20,0.5/(0.5*Fs),'low',hanning(21));
    n=filtfilt(bnoise,1,n);

    % High pass filtering & water surface elevation plots

    [filt_data]=f_highfilt_HP(n,Fs,Fc);

    % Wave dimensions

    % Calculate crossings

    [dcrossings ucrossings]=f_crossings_HP(filt_data);

    % Determine wave dimensions between downcrossings

    [peaks peak_time peak_depths troughs heights period gamma]=f_waveheights_HP(filt_data,dcrossings,n,Fs);

    % Determine area under the wave above the zero crossing

    [wave_area]=f_wavearea_HP(dcrossings,ucrossings,filt_data,Fs);

    % Calculate wave asymmetry and deformation

    [wave_asym wave_def]=f_asymdef_HP(dcrossings,ucrossings,peaks,heights,peak_time);

    % Calculate record skewness and asymmetry

    [total_skew total_asym]=f_totalskewasym_HP(filt_data,Fs);

    % Calculate Ursell Number

    [ur_num wlength c]=f_ursell_HP(heights,peaks,period,n);
    
    

%% Obtaining wave parameters using wave by wave analyses

% Calculate wave parameters for entire time-series
zeroup.total=f_PT_waves_zeroup(data);


%%
% High-pass filter to isolate gravity waves

NonFilt=data; %saves data structural array with other name so we can use f-PT_waves_zeroup again

Fs=4;
Fc=0.05;
Fcc=Fc/(0.5*Fs);
b=fir1(100,Fcc,'high',hanning(101));


for k=1:nbl
    wave.time(k)=data.time(1,k);
    data.press(:,k)=filtfilt(b,1,NonFilt.press(:,k));
end

zeroup.filtHigh=f_PT_waves_zeroup(data);

%% Low-pass filter to obtain Infragravity

Fs=4;
Fc=0.05;
Fcc=Fc/(0.5*Fs);
b=fir1(100,Fcc,'low',hanning(101));


for k=1:nbl
    wave.time(k)=data.time(1,k);
    data.press(:,k)=filtfilt(b,1,NonFilt.press(:,k));
end

zeroup.filtLow=f_PT_waves_zeroup(data);

%% Plot zeroup data

f_PT_plot_zeroup(wave, zeroup)

%% 


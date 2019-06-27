% PT_tool_final

%Created by Brad Morris
%Wednesday 22 March 2017
%Last modified 21.05.2017 (AVC)

clear all
close all

data_raw=f_loadCSVraw;
%data_raw=mat_load;

% %% just for GEOS3009 2018
% data_raw.time=data_raw.time(3000:length(data_raw.time));
% data_raw.press=data_raw.press(3000:length(data_raw.press));



%% Reshape data for spectral analyses

% Reshape data into 30 minute runs
% Comment from reviewer "As a general rule, your segment should be minimum
% five times the lowest period you are looking at, i.e. 5 x 300s = 25 min.
% Conveniently, you could use a cutoff frequency of 0.004 Hz with segments
% of 20 min, or even better 30 min. In comparison, Péquignet et al, 2011 
% uses 2 hours segments"

wave.info=data_raw.info;
rl=60; %min
dt=0.25; %sec
bl=(rl/dt)*60; %burst length
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

clear out
%% Infragravity spectral wave parameters 
% Calculate IG spectral wave parameters
% This calculates the total spectrum of each data segment (PT_power) AND 
% the wave parameters for the infragravity band 
% (f_PT_waves_spectral_infragravity)
for k=1:nbl
    IGwave.time(k)=data.time(1,k);
    p=f_PT_power(data.press(:,k),dt,1);
    
    out=f_PT_waves_spectral_infragravity(p.px,p.f,dt);
    
    IGwave.Hm0(k)=out.hs;
    IGwave.Hrms(k)=out.hrms;
    IGwave.Tm02(k)=out.tm02;
    IGwave.Tm01(k)=out.tm01;
    IGwave.eps(k)=out.eps;
    IGwave.s(k,:)=p.px;
    IGwave.fspec(k,:)=p.f;
end

clear out
%% Plots

f_PT_plot_spectral(wave, IGwave)


%% Obtaining wave parameters using wave by wave analyses
% 
% % Calculate wave parameters for entire time-series
% zeroup.total=f_PT_waves_zeroup(data);
% 
% 
% %%
% % High-pass filter to isolate gravity waves
% 
% NonFilt=data; %saves data structural array with other name so we can use f-PT_waves_zeroup again
% 
% Fs=2;
% Fc=0.05;
% Fcc=Fc/(0.5*Fs);
% b=fir1(100,Fcc,'high',hanning(101));
% 
% 
% for k=1:nbl
%     wave.time(k)=data.time(1,k);
%     data.press(:,k)=filtfilt(b,1,NonFilt.press(:,k));
% end
% 
% zeroup.filtHigh=f_PT_waves_zeroup(data);
% 
% %% Low-pass filter to obtain Infragravity
% 
% Fs=2;
% Fc=0.05;
% Fcc=Fc/(0.5*Fs);
% b=fir1(100,Fcc,'low',hanning(101));
% 
% 
% for k=1:nbl
%     wave.time(k)=data.time(1,k);
%     data.press(:,k)=filtfilt(b,1,NonFilt.press(:,k));
% end
% 
% zeroup.filtLow=f_PT_waves_zeroup(data);
% 
% %% Plot zeroup data
% 
% f_PT_plot_zeroup(wave, zeroup)
% 
% %% 
% 

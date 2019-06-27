% function PT_tool
%
%Created by Brad Morris
%Wednesday 22 March 2017
%Last modified 19.05.2017 (AVC)

clear all
close all

data_raw=loadCSVraw;
% data_raw=mat_load;

wave.info=data_raw.info;

% Reshape data into 45 minute runs
rl=45;%min
dt=0.25;%sec
bl=(rl/dt)*60;
nbl=floor(size(data_raw.time,1)/bl);

data.time=reshape(data_raw.time(1:nbl*bl),bl,nbl);
data.press=reshape(data_raw.press(1:nbl*bl),bl,nbl);

% Calculate IG spectral wave parameters
for k=1:nbl
    IGwave.time(k)=data.time(1,k);
    p=PT_power(data.press(:,k),dt,1);
    
    out=PT_waves_spectral_infragravity(p.px,p.f,dt);
    
    IGwave.Hm0(k)=out.IG_hs;
    IGwave.Hrms(k)=out.IG_hrms;
    %IGwave.Hmax(k)=out.IG_hmax;
    IGwave.Tm02(k)=out.IG_tm02;
    IGwave.Tm01(k)=out.IG_tm01;
    %IGwave.Tpeak(k)=out.IG_tpeak;
    IGwave.eps(k)=out.IG_eps;
    IGwave.s(k,:)=p.px;
    IGwave.fspec(k,:)=p.f;
end

% % Calculate time-series wave parameters
% wave.zeroup=PT_waves_zeroup(data);
% 
% Mean water level for each run
IGwave.mpress=mean(data.press,1);

% Plotting
figure
subplot(3,1,1,'align')
plot(IGwave.time,IGwave.mpress)
title('Spectral Infragravity Component')
datetick('x','HH:MM')
ylabel('Mean water level (m)')
grid on

subplot(3,1,2,'align')
plot(IGwave.time,IGwave.Hm0)
hold on
plot(IGwave.time,IGwave.Hrms,'r')
%plot(IGwave.time,IGwave.Hmax,'g')
hold off
datetick('x','HH:MM')
ylabel('Wave height (m)')
legend('Hm0','Hrms')%,'Hmax')
grid on

subplot(3,1,3,'align')
plot(IGwave.time,IGwave.Tm02)
hold on
plot(IGwave.time,IGwave.Tm01,'r')
%plot(IGwave.time,IGwave.Tpeak,'g')
hold off
datetick('x','HH:MM')
ylabel('Wave period (s)')
legend('Tm02','Tm01')%,'Tpeak')
grid on

% % Write wave data to .csv file
% PT_outCSV(wave)

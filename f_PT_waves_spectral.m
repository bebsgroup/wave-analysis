%function out=f_PT_waves_spectral(p.px,p.f,dt, data.press)
function out=f_PT_waves_spectral(px_in,f_in,dt)
% function out=PT_waves_spectral(px_in,f_in,dt)
%Calculate surface gravity wave parameters
%
%Created by Brad Morris
%Tuesday 5 August 2003
%Last modified 19.05.2017 (AVC)

n21=size(px_in,1);
n=(n21-1)*2;

% %Calculating wave parameters in the gravity (sea-swell) band (>0.05Hz)
jj=find(f_in>=0.05);


f=f_in(jj);
px=px_in(jj);

m0=sum(px)/(n*dt);
m1=sum(f.*px)/(n*dt);
m2=sum((f.^2).*px)/(n*dt);
m4=sum((f.^4).*px)/(n*dt);

hs=4.0.*sqrt(m0);
hrms=sqrt(8*m0);
tm02=sqrt(m0/m2);
tmean=m0/m1;
eps=sqrt(1.0-(m2^2)/(m0*m4));

%	Calculate Hmax and Tpeak using a high cutoff freq.
ii=find(f>=0.05);
fc=f(ii);
pxc=px(ii);
[~,j]=max(pxc);
tpeak=1/fc(j);
%hmax=(2*sqrt(pxc(j)/(2*n*dt)))/fc(j); This is what Brad had, it's wrong
%THis is taken from the scripts that Jak prepared for Steph 
%approximation of maximum wave height during a storm based on 
%Hs (Holthuijsen, 2007, p.82). This is to be used as a conservative 
%estimate of whether waves are breaking
hmax=2.*hs;


out.hs=hs;
out.hrms=hrms;
out.hmax=hmax;
out.tm02=tm02;
out.tm01=tmean;
out.tpeak=tpeak;
out.eps=eps;

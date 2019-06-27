function out=f_PT_waves_spectral(px_in,f_in,dt)
% function out=PT_waves_spectral(px_in,f_in,dt)
%Calculate surface gravity wave parameters
%
%Created by Brad Morris
%Tuesday 5 August 2003
%Last modified Monday 8 December 2003

n21=size(px_in,1);
n=(n21-1)*2;
clear out;

% %Calculating wave parameters in the gravity band (>0.05Hz)
% jj=find(f_in>=0.05&f_in<=0.25);

%Calculating wave parameters in the infragravity band (0.005 - 0.05Hz)
jj=find(f_in>=0.005&f_in<0.05);


f=f_in(jj);
px=px_in(jj);

m0=sum(px)/(n*dt);
m1=sum(f.*px)/(n*dt);
m2=sum((f.^2).*px)/(n*dt);
m4=sum((f.^4).*px)/(n*dt);

hs=4.0.*sqrt(m0);
%hs=3.8.*sqrt(m0);
hrms=sqrt(8*m0);
tm02=sqrt(m0/m2);
tmean=m0/m1;
eps=sqrt(1.0-(m2^2)/(m0*m4));

% %	Calculate Hmax and Tpeak using a high cutoff freq.
% ii=find(f>=0.05);
% fc=f(ii);
% pxc=px(ii);
% [~,j]=max(pxc);
% tpeak=1/fc(j);
% hmax=(2*sqrt(pxc(j)/(2*n*dt)))/fc(j);

out.hs=hs;
out.hrms=hrms;
out.tm02=tm02;
out.tm01=tmean;
out.eps=eps;

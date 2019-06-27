function [F]=f_fw(w1,w2,w3,wk,nbl)

%Calculate Urms based on equation 6 in Monismith et al 2015 

%Urms for w1

    T=w1.wave.Tm02;
    depth=w1.wave.mpress;

    f=4;

    for k=1:(3*nbl)
        first(:,k)=(4*pi^2).*(f.^2).*w1.wave.s(:,k); %first term on Monismith's equation
    end


    second=1./(sinh(wk.w1.*depth).^2); %second term on Monismith's equation

    F.Urms.w1=(first.*second).^1/2;

   
%Urms for w2

    for k=1:(3*nbl)
        first(:,k)=(4*pi^2).*(f.^2).*w2.wave.s(:,k);
    end

    T=w2.wave.Tm02;
    depth=w2.wave.mpress;


    second=1./(sinh(wk.w2.*depth).^2);

    F.Urms.w2=(first.*second).^1/2;

 
%Urms for w3

    for k=1:(3*nbl)
        first(:,k)=(4*pi^2).*(f.^2).*w3.wave.s(:,k);
    end

    T=w3.wave.Tm02;
    depth=w3.wave.mpress;


    second=1./(sinh(wk.w3.*depth).^2);

    F.Urms.w3=(first.*second).^1/2;
    
% Average Urms (sensors 1-2, and 2-3)

F.Urms.avew1=mean(F.Urms.w1);
F.Urms.avew2=mean(F.Urms.w2);
F.Urms.avew3=mean(F.Urms.w3);

F.Urms.avew12=(F.Urms.avew1+F.Urms.avew2)./2;
F.Urms.avew23=(F.Urms.avew2+F.Urms.avew3)./2;

% Friction factors

F.fw.w12=abs(D.rate12)./(0.6*1027.*F.Urms.avew12.^3);
F.fw.w23=abs(D.rate23)./(0.6*1027.*F.Urms.avew23.^3);


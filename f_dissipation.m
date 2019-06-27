function [Eflux, D]=f_dissipation(w1,w2,w3,nbl)

% Spectral dissipation
% Created by Ana Vila-Concejo 30.05.2017
% Last modified AVC 12.06.2017
% 
% According to Pequignet 2011 
% Obaining Energy flux (F)
% Fx(f)=1/2 Cg(f) rho g Snn(f)
% Cg(f) is the group velocity which for shallow water equals 
% sqrt(g h) where h is the water depth.
% rho is the water density and g the gravity acceleration
% Snn(f) is the autospectra which after much searching seems
% to be the spectral density px
% 
% 
% open the matfile with all the data in it

%% Pequignet's method 

rho=1027; %kg/m3 - density of ocean water
g=9.8;    %m/s2 - gravity constant

% assign variables and calculate energy flux (Pequignet, 2011)

h1=w1.wave.mpress;
Eflux.time=w1.data.time;
nbl3=3*nbl;

Snn1=w1.wave.s;

for k=1:nbl3
    Eflux.e1 (:,k)=1/2*sqrt(g*h1(:,k))*rho*g*Snn1(:,k);
end

h2=w2.wave.mpress;

Snn2=w2.wave.s;

for k=1:nbl3
    Eflux.e2 (:,k)=1/2*sqrt(g*h2(:,k))*rho*g*Snn2(:,k);
end

h3=w3.wave.mpress;

Snn3=w3.wave.s;

for k=1:nbl3
    Eflux.e3 (:,k)=1/2*sqrt(g*h2(:,k))*rho*g*Snn3(:,k);
end

%%%% With these calculations I obtain dissipation rates very similar to
%%%% those obtained with Lowe's and Monismith's calculations BUT they are
%%%% much smaller by orders of magnitude, i need to check the units.
%%%% It looks like I obtain kW/m directly? why?
Eflux.d1=Eflux.e2-Eflux.e1;
Eflux.d2=Eflux.e3-Eflux.e2;
Eflux.d1_ave=mean(Eflux.d1);
Eflux.d2_ave=mean(Eflux.d2);

% figure
% plot(Eflux.time(1,:),Eflux.d1_ave, 'm')
% hold on
% plot(Eflux.time(1,:),Eflux.d2_ave, 'c')
% grid
% datetick
% ylabel('Dissipation (spectral) (W/m^3)')
% 
% Eflux.e1_ave=mean(Eflux.e1); 
% Eflux.e2_ave=mean(Eflux.e2); 
% Eflux.e3_ave=mean(Eflux.e3); 
% 
% figure
% plot(Eflux.time(1,:),Eflux.e1_ave)
% hold on
% plot(Eflux.time(1,:),Eflux.e2_ave, 'r')
% plot(Eflux.time(1,:),Eflux.e3_ave, 'g')
% grid
% datetick
% ylabel('Energy flux (spectral) (W/m^2)')
% 
% 
% %contourf(Eflux.time(1,:), w1.wave.fspec, Eflux.e1)

%% Lowe's (2005) method for dissipation (D)

% assign variables and calculate energy flux (Lowe 2005)
% F=E*Cg
% E=1/8 rho g Hrms2
% Cg for shallow water sqrt(g*h)

rho=1027; %kg/m3 - density of ocean water
g=9.8;    %m/s2 - gravity constant

% energy
D.e1=1/8*rho*g*(w1.wave.Hrms).^2;
D.e2=1/8*rho*g*(w2.wave.Hrms).^2;
D.e3=1/8*rho*g*(w3.wave.Hrms).^2;

% radiation stress for shallow water, Sxx=3/2E
D.S1=(3/2)*D.e1;
D.S2=(3/2)*D.e2;
D.S3=(3/2)*D.e3;

% energy flux (Wave power)
D.ef1= D.e1.* sqrt(g.*w1.wave.mpress);
D.ef2=D.e2.* sqrt(g.*w2.wave.mpress);
D.ef3=D.e3.* sqrt(g.*w3.wave.mpress);

% Plot Energy flux (Wave Power)
figure
plot(w1.wave.time, D.ef1)
datetick
hold on
plot(w2.wave.time, D.ef2, 'r')
plot(w3.wave.time, D.ef3, 'g')
grid on
ylabel('Energy flux (W/m)')
legend('w1', 'w2','w3')
axis tight

% figure
% plot(w1.wave.time, D.S1)
% datetick
% hold on
% plot(w2.wave.time, D.S2, 'r')
% plot(w3.wave.time, D.S3, 'g')
% grid on
% ylabel('Radiation Stress (J)')

% Dissipation 
D.d12=D.ef2-D.ef1;
D.d23=D.ef3-D.ef2;

%Dissipation rate

%Distance between sensors
% W01 to W02 = 853 m
% W02 to W03 = 764 m
% W01-W03 = 1575 m

D.dist12=853;
D.dist23=764;
D.dist13=1575;

D.rate12=D.d12/D.dist12;
D.rate23=D.d23/D.dist23;

%Dissipation percentage
D.percent12=(abs(D.d12).*100./D.ef1);
D.percent23=(abs(D.d23).*100./D.ef2);

% %% %% Calculate Urms based on equation 6 in Monismith et al 2015 
% 
% %Urms for w1
% f=4;
% 
% for k=1:(3*nbl)
%     first(:,k)=(4*pi^2).*(f.^2).*w1.wave.s(:,k); %first term on Monismith's equation
% end
% 
% T=w1.wave.Tm02;
% depth=w1.wave.mpress;
% %[wk]=f_wavek(T,depth);
% g=9.81;
% 
% depth=abs(depth);
% depth(isnan(depth))=0; 
% T(isnan(T))=0;
% 
% %if length(depth)>=length(T)
%     for i=1:length(depth)
%         if depth==0;
%         wk(i)=nan;
%         elseif T==0;
%         wk(i)=nan;
%         else
%         %w=2.*pi./T;
%         %h=depth(i);
%         Lo(i)=(g*T(i)^2)/(2*pi)^2; % deepwater wavelength
%         wk(i)=2*pi/Lo(i);
%         %x=fzero('dispn',guess,optimset('disp','off'));
%         %wk(i)=x;
% 	    end
%     end
% 
% second=1./(sinh(wk.*depth).^2); %second term on Monismith's equation
% 
% D.Urms.w1=(first.*second).^1/2;
% 
% D.fw.w1=abs(D.rate12)./(0.6*1027.*D.Urms.w1^3);
% 
% %Urms for w2
% 
% for k=1:(3*nbl)
%     first(:,k)=(4*pi^2).*(f.^2).*w2.wave.s(:,k);
% end
% 
% T=w2.wave.Tm02;
% depth=w2.wave.mpress;
% f_wavek (T,depth);
% 
% second=1./(sinh(wk.*depth).^2);
% 
% D.Urms.w2=(first.*second).^1/2;
% 
% D.fw.w2=abs(D.rate12)./(0.6*1027.*D.Urms.w2^3);


% %% LOWE- FIGURES
% 
% % % figure total dissipation
% % figure
% % plot(w1.wave.time, D.d12/1000, 'm')
% % hold on
% % plot(w1.wave.time, D.d23/1000, 'c')
% % datetick
% % grid on
% % ylabel('Total dissipation (kW/m)')
% 
% %figure dissipation rate
% figure
% plot(w1.wave.time, D.rate12/1000, 'm')
% hold on
% plot(w1.wave.time, D.rate23/1000, 'c')
% datetick
% grid on
% ylabel('Dissipation rate (kW/m^2)')
% legend('w1-2','w2-3')
% axis tight
% 
% 
% % %figure dissipation percentage
% % figure
% % plot(w1.wave.time, D.percent12, 'm')
% % hold on
% % plot(w1.wave.time, D.percent23, 'c')
% % datetick
% % grid on
% % ylabel('% Dissipation')
% % legend('w1-w2', 'w2-w3')
% 
% figure
% subplot(3,1,1,'align')
% %     plot(w1.wave.time, w1.wave.mpress, 'b')
% %     hold on
%     plot(w2.wave.time, w2.wave.mpress, 'r')
% %     plot(w3.wave.time, w3.wave.mpress, 'g')
%     ylabel('Water depth w2 (m)')
%     datetick
%     grid on
%     axis tight
% subplot(3,1,2,'align')
%     plot(w1.wave.time, D.ef1)
%     datetick
%     hold on
%     plot(w2.wave.time, D.ef2, 'r')
%     plot(w3.wave.time, D.ef3, 'g')
%     grid on
%     ylabel('Energy flux (W/m)')
%     legend('w1','w2','w3')
%     axis tight
% subplot(3,1,3,'align')
%     plot(w1.wave.time, D.percent12, 'm')
%     hold on
%     plot(w1.wave.time, D.percent23, 'c')
%     datetick
%     grid on
%     ylabel('% Dissipation')
%     legend('w1-w2', 'w2-w3')
%     axis tight
% 

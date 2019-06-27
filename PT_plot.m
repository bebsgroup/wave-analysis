function PT_plot(wave)
% function PT_plot(wave)
%
%Created by Brad Morris
%Wednesday 22 March 2017
%Last modified Wednesday 22 March 2017

figure(1)
subplot(3,1,1,'align')
plot(wave.time,wave.mpress)
title('Spectral')
datetick('x','HH:MM')
ylabel('Mean water level (m)')
grid on

subplot(3,1,2,'align')
plot(wave.time,wave.Hm0)
hold on
plot(wave.time,wave.Hrms,'r')
plot(wave.time,wave.Hmax,'g')
hold off
datetick('x','HH:MM')
ylabel('Wave height (m)')
legend('Hm0','Hrms','Hmax')
grid on

subplot(3,1,3,'align')
plot(wave.time,wave.Tm02)
hold on
plot(wave.time,wave.Tm01,'r')
plot(wave.time,wave.Tpeak,'g')
hold off
datetick('x','HH:MM')
ylabel('Wave period (s)')
legend('Tm02','Tm01','Tpeak')
grid on

figure(2)
subplot(3,1,1,'align')
plot(wave.time,wave.mpress)
title('ZeroUp')
datetick('x','HH:MM')
ylabel('Mean water level (m)')
grid on

subplot(3,1,2,'align')
plot(wave.time,wave.zeroup.Hsig)
hold on
plot(wave.time,wave.zeroup.Hmax,'g')
hold off
datetick('x','HH:MM')
ylabel('Wave height (m)')
legend('Hsig','Hmax')
grid on

subplot(3,1,3,'align')
plot(wave.time,wave.zeroup.Tz)
datetick('x','HH:MM')
ylabel('Wave period (s)')
grid on

figure (3)
plot(wave.fspec',wave.s')
ylabel('Energy density (m^2 Hz^-1)')
xlabel('Frequency (Hz)')
axis([0 0.4 -inf inf])
grid on




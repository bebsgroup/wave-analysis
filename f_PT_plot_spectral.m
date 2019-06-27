function f_PT_plot_spectral(wave, IGwave)

% Plots PT results from spectral analyses using PT_tool_spectral
% Created by Ana Vila Concejo 19.05.2017

% Plots spectral characteristics of each wave segment in the sea swell
% (ss) band.

figure(1)
    subplot(3,1,1,'align')
    plot(wave.time,wave.mpress)
    title('Spectral Sea-Swell')
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
    legend('ss-Hm0','ss-Hrms','ss-Hmax')
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
    title('Spectral Infragravity')
    datetick('x','HH:MM')
    ylabel('Mean water level (m)')
    grid on

    subplot(3,1,2,'align')
    plot(IGwave.time,IGwave.Hm0)
    hold on
    plot(IGwave.time,IGwave.Hrms,'r')
    hold off
    datetick('x','HH:MM')
    ylabel('Wave height (m)')
    legend('IG-Hm0', 'IG-Hrms')
    grid on

    subplot(3,1,3,'align')
    plot(IGwave.time,IGwave.Tm02)
    hold on
    plot(IGwave.time,IGwave.Tm01,'r')
    hold off
    datetick('x','HH:MM')
    ylabel('Wave period (s)')
    legend('IG-Tm02','IG-Tm01')
    grid on


figure (3)
    plot(wave.fspec',wave.s')
    ylabel('Energy density (m^2 Hz^-1)')
    xlabel('Frequency (Hz)')
    axis([0 0.4 -inf inf])
    grid on
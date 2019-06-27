function f_wavedepth(w1,w2,w3,kk1)



figure
subplot(1,3,1)
    plot(w1.wave.mpress, w1.wave.Hm0, 'o')
    hold on
    plot(w1.wave.mpress(kk1), w1.wave.Hm0(kk1), 'o', 'markerfacecolor', 'b')
    xlabel('Depth (m)')
    ylabel('Hm0 (m)')
    title('W1')
    axis([4.7 7 0 3])
    grid on
    %4.7-6.7 
    %0.27 - 2.6
    
subplot(1,3,2)
    plot(w2.wave.mpress, w2.wave.Hm0, 'r o')
    hold on
    plot(w2.wave.mpress(kk1), w2.wave.Hm0(kk1), 'o', 'markerfacecolor', 'r')
    xlabel('Depth (m)')
    ylabel('Hm0 (m)')
    title('W2')
    axis([1.2 3.5 0 3])
    grid on
   % 1.2-2.7
   % 0.24 -1.5
    
subplot(1,3,3)
    plot(w3.wave.mpress, w3.wave.Hm0, 'o g')
    hold on
    plot(w3.wave.mpress(kk1), w3.wave.Hm0(kk1), 'o', 'markerfacecolor', 'g')
    xlabel('Depth (m)')
    ylabel('Hm0 (m)')
    title('W3')
    axis([2 4.3 0 3])
    grid on
    %2-4.3
    %0.08- 0.83

figure
subplot(2,3,1, 'align')
    plot(w1.wave.mpress, w1.zeroup.filtHigh.Hsig, 'o')
    hold on
    plot(w1.wave.mpress(kk1), w1.zeroup.filtHigh.Hsig(kk1), 'o', 'markerfacecolor', 'b')
    %xlabel('Depth (m)')
    ylabel('Hs (m)')
    title('W1')
    axis([4.7 7 0 3])
    grid on
    %4.7-6.7 
    % 0.27 - 2.6
    
subplot(2,3,2, 'align')
    plot(w2.wave.mpress, w2.zeroup.filtHigh.Hsig, 'r o')
    hold on
    plot(w2.wave.mpress(kk1), w2.zeroup.filtHigh.Hsig(kk1), 'o', 'markerfacecolor', 'r')
    %xlabel('Depth (m)')
    %ylabel('Hs (m)')
    title('W2')
    axis([1.2 3.5 0 3])
    grid on
   % 1.2-2.7
   % 0.24 -1.5
    
subplot(2,3,3, 'align')
    plot(w3.wave.mpress, w3.zeroup.filtHigh.Hsig, 'o g')
    hold on
    plot(w3.wave.mpress(kk1), w3.zeroup.filtHigh.Hsig(kk1), 'o', 'markerfacecolor', 'g')
    %xlabel('Depth (m)')
    %ylabel('Hs (m)')
    title('W3')
    axis([2 4.3 0 3])
    grid on
    %2-4.3
    %0.08- 0.83

subplot(2,3,4, 'align')
    plot(w1.wave.mpress, w1.zeroup.filtLow.Hsig, 'o')
    hold on
    plot(w1.wave.mpress(kk1), w1.zeroup.filtLow.Hsig(kk1), 'o', 'markerfacecolor', 'b')
    xlabel('Depth (m)')
    ylabel('Hs (m)')
    %title('W1')
    axis([4.7 7 0 0.3])
    grid on
    %4.7-6.7 
    % 0.27 - 2.6
    
subplot(2,3,5, 'align')
    plot(w2.wave.mpress, w2.zeroup.filtLow.Hsig, 'r o')
    hold on
    plot(w2.wave.mpress(kk1), w2.zeroup.filtLow.Hsig(kk1), 'o r', 'markerfacecolor', 'r')
    xlabel('Depth (m)')
    %ylabel('Hs (m)')
    %title('W2')
    axis([1.2 3.5 0 0.3])
    grid on
   % 1.2-2.7
   % 0.24 -1.5
    
subplot(2,3,6, 'align')
    plot(w3.wave.mpress, w3.zeroup.filtLow.Hsig, 'o g')
    hold on
    plot(w3.wave.mpress(kk1), w3.zeroup.filtLow.Hsig(kk1), 'o g', 'markerfacecolor', 'g')
    xlabel('Depth (m)')
    %ylabel('Hs (m)')
    %title('W3')
    axis([2 4.3 0 0.3])
    grid on
    %2-4.3
    %0.08- 0.83



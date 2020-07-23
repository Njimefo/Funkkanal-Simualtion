coefs = radioFadingChannel(1e6,0); %K = 0 for Rayleigh Kanal



xR= real(coefs);
yIm = imag(coefs);

phasen= angle(coefs);
amplituden = abs(coefs);


subplot(2,2,1);
histogram(phasen,200);
title('Phasendiagram');
subplot(2,2,2);
histogram(amplituden,200);
title('Amplitudendiagramm');
subplot(2,2,3);
plot(xR,yIm,'.'); grid on, axis square, axis([-1 1 -1 1]*5);
title('Gauﬂverteilung in Im und Re Diagramm');


subplot(2,2,4);
histogram2(xR,yIm,200);
title('Gauﬂverteilung in Im und Re Diagramm (3D View)');

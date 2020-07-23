function Simulation_awgn(constellation)
nBitsPerLoop = 10e3;
nBits = nBitsPerLoop;
eSignal = generateBits(nBits);
mapped_eSignal = mapper(eSignal,constellation);
mapped_eSignal = mapped_eSignal/mitlLeist(mapped_eSignal);
ebN0dB = 10; %SNR pro Bit
ebN0= DB2Linear(ebN0dB);
SNRs = ebN0*log2(length(constellation));
SNRsdB = Linear2DB(SNRs);
noiseSignal = awgn(mapped_eSignal,SNRsdB,'measured');

subplot(1,1,1);
plot(real(mapped_eSignal),imag(mapped_eSignal),'b.');
title('Ursprüchliches Signal');

subplot(1,2,2);
plot(real(noiseSignal),imag(noiseSignal),'r.');
title('verrauschtes Signal');
end
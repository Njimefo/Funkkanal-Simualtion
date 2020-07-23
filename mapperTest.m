function mapperTest( )
% varargin
% narginchk(0,1);
% if nargin==0
%     de=2;
% else
%     de=varargin{1};
% end
% global simulation parameters



nMinErr=100;
nBitsPerLoop = 10e3;
nMaxBits= 100*nBitsPerLoop;

BPSK = [-1-1j, 1+1j];
QPSK = [-1-1j, 1-1j, -1+1j, 1+1j]; %QPSK with Gray mapping
QAM8 = [-1-1i 1-1i -1+1i 1+1i -1i*(1+sqrt(3)) 1+sqrt(3) -1-sqrt(3) 1i*(1+sqrt(3))];
QAM16 = [-3+3i  -3+1i  -3-3i  -3-1i  -1+3i  -1+1i  -1-3i  -1-1i   3+3i   3+1i 3-3i   3-1i   1+3i   1+1i   1-3i   1-1i];
QAM32 = [-3+5i  -1+5i  -3-5i  -1-5i  -5+3i  -5+1i  -5-3i  -5-1i  -1+3i  -1+1i -1-3i  -1-1i  -3+3i  -3+1i  -3-3i  -3-1i   3+5i   1+5i   3-5i   1-5i   5+3i  5+1i   5-3i   5-1i   1+3i   1+1i   1-3i   1-1i   3+3i   3+1i   3-3i   3-1i];
QAM64 = [-7+7i  -7+5i  -7+1i  -7+3i  -7-7i  -7-5i  -7-1i  -7-3i  -5+7i  -5+5i -5+1i  -5+3i  -5-7i  -5-5i  -5-1i  -5-3i  -1+7i  -1+5i  -1+1i  -1+3i  -1-7i -1-5i  -1-1i  -1-3i  -3+7i  -3+5i  -3+1i  -3+3i  -3-7i  -3-5i  -3-1i  -3-3i  7+7i   7+5i   7+1i   7+3i   7-7i   7-5i   7-1i   7-3i   5+7i   5+5i   5+1i  5+3i   5-7i   5-5i   5-1i   5-3i   1+7i   1+5i   1+1i   1+3i   1-7i   1-5i  1-1i   1-3i   3+7i   3+5i   3+1i   3+3i   3-7i   3-5i   3-1i   3-3i];
PSK8 = [- sqrt(2)/2 + sqrt(2)/2*1i, -1 + 0*1i,  0 - 1*1i, -sqrt(2)/2 -sqrt(2)/2*1i,  0 + 1*1i, sqrt(2)/2 + sqrt(2)/2*1i, sqrt(2)/2 - sqrt(2)/2*1i,  1- 0*1i];
PSK16 = [-0.707107+0.707107i, -0.92388+0.382683i, -0.92388-0.382683i, -1+0i, 0.382683-0.92388i,  0-1i, -0.707107-0.707107i, -0.382683-0.92388i, -0.382683+0.92388i,  0+1i, 0.707107+0.707107i,  0.382683+0.92388i, 0.707107-0.707107i,  0.92388-0.382683i,  0.92388+0.382683i,  1-0i];

constellation =  QPSK;
%nBits = 1e6 ; % simulate nBits bits per simulation loop

 nBits = nBitsPerLoop;
eSignal = generateBits(nBits);

mapped_eSignal = mapper(eSignal,constellation);

%Normierung des Signals auf mitlere Leistung
mapped_eSignal = mapped_eSignal/mitlLeist(mapped_eSignal);


for K = 0:2:10 
hold on
 %Je kleiner ist der Wert desto mehr gibt es Rauschen
 % SNR (per bit) in dB
 awgnAnalyticsErrors = [];
 awgnSimulationErrors = [];
 RayleighNumericErrors = [];
 RayleighAnalyticsErrors = [];
 counter = 1;
 
 ebN0dBs = 1:1:20; 
 %plot(real(mapped_eSignal),imag(mapped_eSignal),'r*');
for index = 1:length(ebN0dBs)
    
    ebN0dB=ebN0dBs(index);
    
    ebN0= DB2Linear(ebN0dB);
    SNRs = ebN0*log2(length(constellation));
    SNRsdB = Linear2DB(SNRs);

%Measured sagt, dass awgn selber das Signal messen soll und in 1 Watt also
% 0 dB konvertieren soll, dann muss man nicht mehr das Eingangssignal um
% seine mitlere Leistung normieren
% noiseSignal = awgn(mapped_eSignal,SNRsdB,'measured');
% 
% 
% plot(real(noiseSignal),imag(noiseSignal),'b.');
% xlabel('Time');
% ylabel('Pulse');
%  hold on
%  axis square %quadratische Axen
% axis([-1 1 -1 1]*2); %Anpassung der Axen
% 
% plot(real(mapped_eSignal),imag(mapped_eSignal),'r*');
% legend('Noise Signal','Input Signal');
%mapped_eSignal = noiseSignal;
% hold off




noiseSignal = awgn(mapped_eSignal,SNRsdB,'measured');
decided_eSignal = decision (noiseSignal,constellation);
demapped_eSignal = demapper(decided_eSignal,constellation);
[~, awgnSimulationErrors(1,counter)] = countErrors(eSignal, demapped_eSignal);


awgnAnalyticsErrors(1,counter) = 0.5*erfc(sqrt(ebN0));

generatedChanelCoefs = radioFadingChannel(length(noiseSignal),K);

generatedChanelCoefsReformed = generatedChanelCoefs.';
mappedSignal_Mal_ChanelCoefs = generatedChanelCoefsReformed.*mapped_eSignal;
noiseSignal_Rayleigh=awgn(mappedSignal_Mal_ChanelCoefs,SNRsdB,'measured');
equalizedSignal_Rayleigh = noiseSignal_Rayleigh./generatedChanelCoefsReformed;
Rayleigh_decided_eSignal= decision (equalizedSignal_Rayleigh,constellation);
Rayleigh_demapped_eSignal = demapper(Rayleigh_decided_eSignal,constellation);
[~, RayleighNumericErrors(1,counter)] = countErrors(eSignal, Rayleigh_demapped_eSignal);

RayleighAnalyticsErrors(1,counter)=(1/2)*(1-sqrt(ebN0/(1+ebN0)));

counter = counter + 1;
end





% plot(ebN0dBs,awgnAnalyticsErrors,'r');
% plot(ebN0dBs,awgnSimulationErrors,'mo');
% plot(ebN0dBs,RayleighNumericErrors,'s');
% plot(ebN0dBs,RayleighAnalyticsErrors,'k');
plot(ebN0dBs,awgnAnalyticsErrors);
plot(ebN0dBs,awgnSimulationErrors,'o');
plot(ebN0dBs,RayleighNumericErrors,'s');
plot(ebN0dBs,RayleighAnalyticsErrors);
axis([1 10 1e-6 1]);

ylabel('BER');
xlabel('AWGN: SNR, Diversity: Nr*SNR / dB');
set(gca,'YScale','log');




end
hold off
%legend('AWGN','Numeric AWGN','Rayleigh','Rayleigh Analytics');
end
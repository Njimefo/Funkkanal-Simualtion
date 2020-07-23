function y= radioFadingChannel(nSamp,K)

realValues = randn(nSamp,1); %Generiert nSamp Zahlen, die schon gaußverteilt sind (als mean=0)
imagValues = randn(nSamp,1);
y = realValues+ 1i*imagValues; %Erzeuge die komplexen Zahlen
y = y/sqrt(mitlLeist(y));  %Hier noch Rayleigth Kanal Koefizienten : Normierung auf die Wurzel der  mittleren Leistung-also keine Dämpfung oder Verstärkung

Pnlos = mitlLeist(y);
Plos = K*Pnlos; % müsste gleich K sein da Pnlos = 1 da y normiert ist

phis = rand(nSamp,1)*2*pi; % von elt = A*e^(i*phi) Phasenwinkel generieren, gleich verteilt zwischen 0 und 2pi also um einen Kreis, sprich gleiche Amplituden

%K  in der Wurzel weil P =  ( A die Amplitude also Elt = A*e^(j*phi))

A= sqrt(Plos); % Amplitude denn P(Leistung) = |A|^2 ==> A = sqrt(P);
losComponents  = A*exp(1i.*phis); %losComponent = A*e^(phi*i)

y = y+losComponents; %h = sum(hNlos) + hLos mit hNlos = y von oben . Siehe Skript Funkkanal S.21
y = y/sqrt(mitlLeist(y)); %Normierung damit kein Dämpfung oder Verstärkung
end
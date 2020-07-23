function Simulation_mapper()
%Simulation_mapper: Simulationsmethode der <a href= "matlab:help('mapper')">mapper</a> Funktion
%Dabei werden 1000000 Bits mit der Methode <a href=
%"matlab:help('generateBits')">generateBits</a> generiert
%Anschlieﬂend werden die Bits in Symbole mithilfe der Konstellationspunkte
%umgewandelt und in einer repr‰sentiert. Zu beachten ist dass das Modulationsformat <a href=
%"matlab:web('https://de.wikipedia.org/wiki/Quadraturphasenumtastung','-browser')">QPSK</a>
%hier Verwendung findet.

QPSK = [-1-1j, 1-1j, -1+1j, 1+1j]; 

bits = generateBits(1e6); %Generierung der Bitfolge
symbole = mapper(bits,QPSK);%Umwandlung in Symbolen
plot(real(symbole), imag(symbole), '*'); %Darstelung der Symbole
axis([-3 3 -3 3]); %Darstellung des Anzeigebereichs

%Beschriftung der Axen
xlabel('Realer Teil'); 
ylabel('Imagin‰rer Teil');

title('Umgewandelte Bitfolge in Symbolen (QPSK-Modulationsformat)');
end
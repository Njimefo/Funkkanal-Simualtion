function Simulation_generateBits()
%Simulation_generateBits: Simulationsmethode der <a href= "matlab:help('generateBits')">generateBits</a> Funktion
%Dabei werden 50 Bits zuf�llig generiert und dargestellt


anzahlBits = 50; %Festlegung der Anzahl der zu generierenden Bits
genBits = generateBits(anzahlBits); %Generierung der Bitfolge
stairs(genBits,'LineWidth',2); %Darstellung der generierten Bitfolge mit Linienst�rke 2
axis([1 anzahlBits+1 0 1]); %Festlegung des Bereiches des Koodinatensystem
xlabel('Bit-Position');
ylabel('Bit-Wert');
title('50 zuf�llig generierte Bits');
end
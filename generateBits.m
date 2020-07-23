function y = generateBits(nBits)
%generateBits: Generiert zufällig eine Bitfolge
%nBits = Anzahl der Bits, die in der Bitfolge enthalten sind
%Siehe Beispiel  <a href= "matlab:Simulation_generateBits">hier</a>

%Generierung der Bitfolge
y= randi([0, 1],1,nBits);
end
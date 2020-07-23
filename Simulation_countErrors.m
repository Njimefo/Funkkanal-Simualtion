function Simulation_countErrors()
%Simulation_countErrors: Simuliert die Berechnung der Fehlerberechnung
%Methode <a href=
%"matlab:help('countErrors')">countErrors</a>
%Dabei werden Bits mit der Methode <a href=
%"matlab:help('generateBits')">generateBits</a> generiert, dann mit der
%Funktion <a href="matlab:help('mapper')">mapper</a> auf Basis der QPSK Format
%in Symbolen umgewandelt, anschließend mit der Funktion
%<a href="matlab:help('demapper')">demapper</a> auf Basis der QPSK Format i
%ursprüchliches zurückgewandelt. Zum Schluss wird die Anzahl der Fehler
%zwischen dem urspünglichen Signal und dem empfangenen Signal berechnet,
%welche Null sein müsste, da keine Störung zugefügt wurde.

QPSK = [-1-1j, 1-1j, -1+1j, 1+1j]; 

bits = generateBits(100); %Generierung der Bitfolge
symbole = mapper(bits,QPSK);%Umwandlung in Symbolen

empBits = demapper(symbole,QPSK); %Zurückwandlung in Bits

[nErr, ber] = countErrors(empBits, bits);

assert(nErr==0,'Test fehlgeschlagen.\nAnzahl der Fehler nicht gleich 0 sondern %d',nErr);
assert(ber==0,'Test fehlgeschlagen.\nFehlerprozent nicht gleich 0 sondern %d',ber);
disp('Simulation_countErrors erfolgreich durchgeführt');
end
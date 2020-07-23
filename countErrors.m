function [nErr, ber] = countErrors(x, bits)
%countErrors: Berechnet die Anzahl der Fehler und den Fehlerprozent
%zwischen der empfangenen Bitfolge und der urspünglich gesendeten Bitfolge
%x: Empfangene Bits
%bits: ursprünglich gesendete Bits
%Siehe Beispiel hier in der Methode <a href=
%"matlab:edit('Simulation_countErrors')">Simulation_countErrors</a>

%Indexen der Elemente, die sich in den beiden Bitfolgen  nicht ähneln
errors = x(x~=bits);

%Anzahl der der Indexen bzw. Fehler ermitteln
[~,nErr]= size(errors);

%Gesamte Anzahl der Bitfolge
[~,eltSize] = size(bits);

%Fehlerprozent berechnen
ber = nErr/eltSize;

end
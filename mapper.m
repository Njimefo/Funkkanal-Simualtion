function y = mapper(bits, constellation)
%mapper: Generiert zufällig eine Bitfolge
%bits = Bitfolge, die auf Basis der angegebenen Konstellationpunkte in
%Symbole umzuwandeln sind.
%constellation = Konstellationspunkte
%Siehe Beispiel  <a href= "matlab:Simulation_mapper">hier</a>

constL = length(constellation); %Anzahl der Konstellationspunkte 
bitsL = length(bits); %Anzahl der Bits in der Bitfolge
step = log2(constL); %log basis 2 von der Anzahl der Konstellationspunkte berechnen also 2^step = constL lösen

if(rem(step,1) ~= 0) %Checkt ob die Anzahl der Konstellationspunkte eine Potenz von 2 ist
    error('Die Anzahl der Konstellationspunkte muss eine Potenz von 2 sein.');
end

if (rem(bitsL,step) ~= 0)
   error('Die Bitslänge entspricht nicht einem Vielfachen des Konstellationschrittes (aus dem Konstellationsvektor berechnet)');
end

indexes = zeros(bitsL/step,1); %Initialisierung der Indexen mit 0 als Werte drin

%Neustrukturierung der Bitfolge 
%Z.B. :
%bits = 0100111110
%setp = 2
%splitted_bits = [0 1] [0 0] [1 1] [1 1] [1 0]
splitted_bits = reshape(bits,step,[]); 
basisCoefs = 2.^(step-1:-1:0); % Bits-Numerierung mit left-msb mapping 
indexes = (basisCoefs*splitted_bits)+1;% Berechung der Indexen und addieren von 1 denn Matlab-Index startet mit 1
y= constellation(indexes); %entsprechende Symbole aus dem Konstellationvektor


end



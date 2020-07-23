function y = decision (x, constellation)
%decision: Die Methode geht jeden Abtastewert durch und
%entscheidet, welchem Symbol urspr�nglich eingegangen war, indem er den
%kleinsten Abstand zwischen dem Symbol und jedem m�glichen
%Konstellationspunkt berechnet und holt den Konstellationspunkt, zu dem das
%Symbol den kleinsten Abstand hat
%x: Empfangenes Signal im Empf�nger
%constellation: Konstellationspunkte
%return: Gibt die entschiedenen Abtastwerte zur�ck

%Mittlere Leistung der Konstellationspunkte
constellation_mean = mitlLeist(constellation);

if(constellation_mean >0)
    %Normierung des Signales auf mitlere Leistung der Konstellationspunkte
    %da der potentielle Kanal die mittlere Leistung des Signals unter Umst�nden �ndert
    x = x/constellation_mean;   
end


[cxL,cyL] = size(constellation);

%Verbindungsvektor zwischen jedem Abtastewert und jedem m�glichen
%Konstellationspunkt
if cxL>cyL && cyL == 1
  diffVects = bsxfun(@minus,x,constellation);
elseif cxL<cyL && cxL == 1
    diffVects = bsxfun(@minus,x,constellation.');
else
    error('Die Konstellationspunkte haben kein richtiges Format');
end

%Berechnung des Abstands der Verbindungsvektoren
distances = abs(diffVects);

%Indexen der minimalen Abst�nde
[~,minDistIn] = min(distances,[],1);

%Indexen zu entsprechenden Konstellationspunkten zuordnen
y = constellation(minDistIn);



end


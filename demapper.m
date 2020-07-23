function y = demapper(x,constellation)
%demapper: wandelt auf Basis der angegebenen Konstellationspunkte das mit Symbolen angegebene Signal in ursprüngliches
%Signal zurück.
%x: empfangene und entschiedene Werte
%constellation: Konstellationspunkte

[cxL,cyL] = size(constellation);
[sxL,syL] = size(x);

%Formate-Check und Holen der verschiedenen Längen (Konstellationspunkte und
%empfangenes Signal)
if sxL>syL && cyL == 1
    sL = sxL;
elseif sxL<syL && cxL == 1
    sL = syL;
else
    error('Das Signal haben kein richtiges Format');
end
if cxL>cyL && cyL == 1
    cL = cxL;
elseif cxL<cyL && cxL == 1
    cL = cyL;
else
    error('Die Konstellationspunkte haben kein richtiges Format');
end


%Anzahl der Bits, die pro Symbol entstehen 
split_step = log2(cL);

%suksezives Herausnehmen der Bits
for iPos= 0:sL-1
   %Herausfinden des Index des entsprechenden Konstellationspunktes und
   %Zurückführung der Index in normalen Bereich also mit Start 0
   indice = find(constellation==x(iPos+1))-1; 

   startSplitPos= iPos*split_step +1; %Start Index der Position der entstehenden Bitfolge
   endSplitPos = startSplitPos + split_step-1;%End Index der Position der entstehenden Bitfolge
   bitsStr(startSplitPos:endSplitPos) = dec2bin(indice,split_step); %Konvertierung des Wertes in Bitfolge mit gegebener Bitlänge und Einfügen der Bitfolge in einer Zeichenkette
end

y = reshape(bitsStr.'-'0',1,[]);%Type cast (Neustrukturierung der Bit-Zeichenkente und Umwandlung in Zahlen


end
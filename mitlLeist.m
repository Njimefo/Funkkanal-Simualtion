%Mittelleistung
function result = mitlLeist(constellation)
%conjConst = conj(constellation);
quadratConst = abs(constellation).^2;
result = mean(quadratConst);
end
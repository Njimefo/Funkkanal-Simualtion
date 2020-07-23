function y = pRice(phi)
global K;
global ebN0;
term = (1+K).*sin(phi).*sin(phi);
y = (term/(term+ebN0)).*exp(-(K*ebN0)/(term+ebN0));
end
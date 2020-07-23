%f(x)=A*x^.2+B*x +C;
clear;
clc;
format compact;
echo off %Leerzellen unterdr?cken
disp('Nullstellen Berechnen')
disp('A*x^.2+B*x +C=f(x)');

A=input('A =');
B=input('B =');
C=input('C =');
 p = [A B C];
 
 roots(p);
 x =(-10:0.1:10);
 polyval(p,x);
 subplot(1,2,1);
 
  %0 zu o
 plot(x,polyval(p,x),roots(p),polyval(p,roots(p)),'o');

 title('Matlab Colette');
 xlabel('x-wert');
 ylabel('y-wert');
 grid on
 text(roots(p),polyval(p,roots(p)),'Nullstellen');
 %text('0,0','Nullstellen');
 c= B^2/(4*A);
 p=[A B C]; % Vektor der Eingabe Wert
 roots(p)
 %s du subplot weg
 subplot(1,2,2)
 
 %0 zu o
 plot(x,polyval(p,x),roots(p),polyval(p,roots(p)),'o') %Graf erstellen
 %title('0,0','Nullstellen');
 text(roots(p),polyval(p,roots(p)),'Nullstellen');
 xlabel('x-wert');
 ylabel('y_wert');
 %text('0,0','Nullstellen');
 grid on; %Raster an
 
nBits = 100;
signal = generateBits(nBits);
time = 0:1:nBits-1;
graph = stairs(signal);
graph.LineWidth = 1.5;
xlabel('Time');
ylabel('Pulse');

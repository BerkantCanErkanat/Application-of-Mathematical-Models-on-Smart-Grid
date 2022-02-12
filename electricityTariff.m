function cost = electricityTariff()
cost = 1:24;

firstRand = 0.2*rand(1,11)+1.2;
secondRand = 0.2*rand(1,4)+2.0;
first_third = 0.1*rand(1,6)+0.7;
second_third = 0.1*rand(1,3)+0.7;

cost(cost<7) = first_third;
cost((cost>=7) & (cost<18)) = firstRand;%sabah 6 ile aksam 17 arasındaki elektrik fiyatları 1.2 1.4
cost((cost>=18) & (cost<22)) = secondRand;%saat 17 ile 22 arasında ise 2.0 2.2
cost(cost>=22) = second_third;%saat 22 ile sabah 6 arası 0.7 0.8

makePlot(cost,'HOURLY ELECTRICITY TARIFF','HOURS','TL',7);
end
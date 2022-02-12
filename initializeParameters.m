function parameters = initializeParameters()

%electricity tariff by hours
parameters.c = electricityTariff();

%electricity tariff sorted for load shifting algorithm
[~,parameters.sortedHours] = sort(parameters.c);

%appliances 
[parameters.appsWoutLS,parameters.max_loadWoutLS] = initializeAppliances();

%CASE 1
%WITHOUT LOAD SHIFTING PV NOT INCLUDED
parameters.resultWoutLSNOPV = calculate(parameters.appsWoutLS,parameters.c,1);
makePlot(parameters.resultWoutLSNOPV.powerDemanded,"1 month power demand from grid before load shift","Hours","kW",1);

%do load shifting
[parameters.appsWithLS,parameters.max_loadWithLS] = loadShifting();

%AFTER LOAD SHIFTING PV NOT INCLUDED
parameters.resultWithLSNOPV = calculate(parameters.appsWithLS,parameters.c,1);
makePlot(parameters.resultWithLSNOPV.powerDemanded,"1 month power demand from grid after load shift","Hours","kW",2);

%CASE 2
%BEFORE LOAD SHIFTING PV INCLUDED
parameters.resultWoutLSPV = calculate(parameters.appsWoutLS,parameters.c,44);
makePlot(parameters.resultWoutLSPV.powerDemanded,"1 month power demand from grid before load shift PV INCLUDED","Hours","kW",3);

%AFTER LOAD SHIFT PV INCLUDED
parameters.resultWithLSPV = calculate(parameters.appsWithLS,parameters.c,44);
makePlot(parameters.resultWithLSPV.powerDemanded,"1 month power demand from grid after load shift PV INCLUDED","Hours","kW",4);

%plot home 2 grid energy 
makePlot(parameters.resultWoutLSPV.h2grid,"H2G Energy before load shift","Days","KW",5);
makePlot(parameters.resultWithLSPV.h2grid,"H2G Energy after load shift","Days","KW",6);

%total cost histogram
figure (8)
bar(1,parameters.resultWoutLSNOPV.totalCost)
hold on
bar(2,parameters.resultWithLSNOPV.totalCost)
hold on
bar(3,parameters.resultWoutLSPV.totalCost)
hold on
bar(4,parameters.resultWithLSPV.totalCost)
title('TOTAL COST');
ylabel('TL')
set(gca, 'XTick',1:4,'XTickLabel',{'WoutLSNOPV','WithLSNOPV','WoutLSPV','WithLSPV'});
legend('WoutLSNOPV','WithLSNOPV','WoutLSPV','WithLSPV');

%total cost histogram
figure (9)
bar(1,parameters.resultWoutLSNOPV.PARWOutPV)
hold on
bar(2,parameters.resultWithLSNOPV.PARWOutPV)
hold on
bar(3,parameters.resultWoutLSPV.PARWithPV)
hold on
bar(4,parameters.resultWithLSPV.PARWithPV)
title('PAR');
set(gca, 'XTick',1:4,'XTickLabel',{'WoutLSNOPV','WithLSNOPV','WoutLSPV','WithLSPV'});
legend('WoutLSNOPV','WithLSNOPV','WoutLSPV','WithLSPV');

makePlot(parameters.resultWoutLSNOPV.cost,'HOURLY COST IN 1 MONTH WoutLSNOPV','HOURS','TL',10);
makePlot(parameters.resultWithLSNOPV.cost,'HOURLY COST IN 1 MONTH WithLSNOPV','HOURS','TL',11);
makePlot(parameters.resultWoutLSPV.cost,'HOURLY COST IN 1 MONTH WoutLSPV','HOURS','TL',12);
makePlot(parameters.resultWithLSPV.cost,'HOURLY COST IN 1 MONTH WithLSPV','HOURS','TL',13);
end
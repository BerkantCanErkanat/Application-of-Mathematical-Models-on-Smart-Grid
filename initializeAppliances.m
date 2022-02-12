function [appliances,max_load] = initializeAppliances()
%cell sırasına dikkat edelim A2 den hep baslar ama bitise dikkat
[~,~,appliances] = xlsread("appliances.xlsx","A2:G21");
%değerleri number a çevirmek için 2 4 5 7 indexlerdekileri cevir
for ii = 1:size(appliances,1) % row numbers
    appliances{ii,2} = str2double(appliances{ii,2});
    appliances{ii,4} = str2double(appliances{ii,4});
    appliances{ii,5} = str2num(appliances{ii,5});
    appliances{ii,7} = str2num(appliances{ii,7});
end
num_of_apps = size(appliances,1);
powerOfCurrentApps = zeros(1,24);
for ii = 1:num_of_apps
    powerOfCurrentApps = powerOfCurrentApps + appliances{ii,2} * appliances{ii,5};
end
max_load = max(powerOfCurrentApps);
end
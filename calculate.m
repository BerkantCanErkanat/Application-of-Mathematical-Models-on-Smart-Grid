function result = calculate(apps,c,flag)
%flag == 44 ise PV INCLUDED
powerIndex = 2;    %app gücü indexi
workOrNotHour = 5; %app in bir gün de saatlere gore calısma arrayi indexi
workOrNotDay = 7;  %app in bir ayda güne göre çalışma arrayi indexi
num_of_apps = size(apps,1);
result.powerDemanded = zeros(1,24);%bir günlük tüm güçler saate göre pv tarafından azalacak
result.powerDemandOfHome = zeros(1,24); %pv tarafından azalmayan evin direkt ihtiyacı bu
result.h2grid = zeros(1,30); %her gün için gride ne kadar guc verebiliriz tutan array

for kk = 1:30
    for ii=1:num_of_apps
        if apps{ii,workOrNotDay}(kk) == 1 % o gün bu app çalışıyor
            temp = apps{ii,workOrNotHour}*apps{ii,powerIndex};
            %bir günlük güçleri saatlik topla
            result.powerDemanded = result.powerDemanded + temp;
        end
    end
    if flag == 44 % grid aktif
    %pv nin etkisini power demand from gridde goster
    % Month, panel sayısı, ve panel tipi paremetrik olmalı
    [solar2Home, solar2Grid] = SolarEnergy(1, 4, 1); %18: 17-18 arası 22: 21-22 arası
    [result.powerDemanded,remainingEnergy] = reducePowerDemandFromGrid([solar2Home, solar2Grid] ,18,22,result.powerDemanded);
    % h2g yapılacak enerji
    result.h2grid(kk) = remainingEnergy;
    end
    
end
%1 ay içinde saat bazında ödenecek tutar vergi hariç
result.cost =  result.powerDemanded.*c;

%1 ay için total ödenecek tutar
result.totalCost = sum(result.cost);

%PAR with PV
if flag == 44
    result.PARWithPV = max(result.powerDemanded)/mean(result.powerDemanded);
else
    %PAR without PV
    result.PARWOutPV = max(result.powerDemanded)/mean(result.powerDemanded);
end

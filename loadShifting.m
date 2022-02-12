function [new_apps,max_load] = loadShifting()

%get the constraints
constraints = constraint();
%get the reasonable hours to shift the appliances
[~,indexes] = sort(electricityTariff());

%index sırasını veriyoruz ki tüm appliancelarda dolaşalım
old_apps = initializeAppliances();
num_of_apps = size(old_apps,1); %app sayısı
type=3; %type icin index
work_hour=4; %work hour icin index
dissatisfaction=6; %dissatisfaction icin index
workOrNotHour=5; %work or not arrayi icin index
count=1;
powerIndex = 2;    %app gücü indexi
%fixed elementlerin saatlik gucunu alalım
powerOfCurrentApps = zeros(1,24);
for ii = 1:num_of_apps
    if strcmp(old_apps{ii,type},'fixed')
        powerOfCurrentApps = powerOfCurrentApps + old_apps{ii,powerIndex} * old_apps{ii,workOrNotHour};
    end
end
for jj=1:num_of_apps
    if strcmp(old_apps{jj,type},constraints.ALLOWED_TYPE)
        if old_apps{jj,dissatisfaction} == constraints.ALLOWED_DISS_LEVEL
            work_hour_temp = ceil(old_apps{jj,work_hour});
            old_apps{jj,workOrNotHour}=zeros(1,24);
            while count <= length(indexes)
                tempPower = zeros(1,24);
                realIndexes = indexes(count):(indexes(count) + work_hour_temp - 1);
                realIndexes(realIndexes > 24) =  realIndexes(realIndexes > 24) - 24;
                tempPower(realIndexes) = powerOfCurrentApps(realIndexes);
                tempPower(realIndexes) = tempPower(realIndexes) + old_apps{jj,powerIndex};
                if all(tempPower(realIndexes) < constraints.MAX_LOAD)
                    powerOfCurrentApps(realIndexes) = powerOfCurrentApps(realIndexes) + old_apps{jj,powerIndex};
                    %powerOfCurrentApps
                    old_apps{jj,workOrNotHour}(realIndexes)=1;
                    %disp([old_apps{jj,workOrNotHour},old_apps{jj,1}])
                    count = count + 1;
                    break;
                end
                count = count + 1;
            end
        end  
    end
end
 max_load = max(powerOfCurrentApps);
 new_apps=old_apps;
end
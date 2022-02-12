function [solar2Home, solar2Grid] = SolarEnergy(month, n, panelType)

% Şebekeye basılan enerji miktarı total costtan düşülecek

    batteryLimit = 2; % Max limit of storage in kwh
    averageSunbathHours = [2.4 3.2 4.4 6.1 8.3 10.2 10.9 10.1 8.1 5.5 3.6 2.5]; % Monthly Averages (M)
    solarPanelPowerCapacities = [0.3; 0.5; 1; 2]; % in kWatts (for different panel types) (S)
    nS = n * solarPanelPowerCapacities;
    
    nS(nS > 10) = 10; % Regulation constraint
    
    upperLimitPercentage = 0.75; % Upper constraint to protect battery
    lowerLimitPercentage = 0.40; % Lower constraint to protect battery
    
    produce = nS * averageSunbathHours; % Total solar energy production
    solar2Home = produce(panelType, month); % Energy which is sent to home
    solar2Grid = 0; % Energy which is sent to grid
    
    if solar2Home >= batteryLimit*upperLimitPercentage
        solar2Grid = solar2Home - batteryLimit*upperLimitPercentage;
        solar2Home = solar2Home - solar2Grid;
    end
    
    lowLimit = batteryLimit * lowerLimitPercentage; 
    
    if lowLimit >= solar2Home
        solar2Home = 0;
    end
    
end
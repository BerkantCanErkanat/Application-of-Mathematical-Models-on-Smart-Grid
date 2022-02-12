function [powerDemandedAfterPV,remainingEnergyFromHome] = reducePowerDemandFromGrid(remainingEnergy,tStart,tFinish,currentPD)
remainingEnergyFromHome = 0;
for i=tStart:tFinish
    if remainingEnergy(1) >= currentPD(i)
        remainingEnergy(1) = remainingEnergy(1) - currentPD(i);
        currentPD(i) = 0;
    else
        currentPD(i) = currentPD(i) - remainingEnergy(1);
        remainingEnergy(1) = 0;
    end
end
remainingEnergyFromHome = remainingEnergyFromHome + remainingEnergy(2) + remainingEnergy(1);
powerDemandedAfterPV = currentPD;
end
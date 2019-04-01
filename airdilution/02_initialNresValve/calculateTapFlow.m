function results=calculateTapFlow(data)

flows=[data.flow];


TAP=data(isnan(flows));
for ii=1:length(TAP)
  TAP(ii).flow=0;
end

warning off
TAPr=analyseEthanol(TAP);
warning on
mu=mean(TAPr.deltaF);


MFC=data(~isnan(flows));
MFCr=analyseEthanol(MFC);



grid

xHat=(mu/MFCr.stats.b(2))-MFCr.stats.b(1);

hold on
plot(repmat(xHat,length(TAP),1),TAPr.deltaF(:),'or')
plot(xHat,mu,'*r')
hold off
title(sprintf('tap=%1.3f l/min',xHat))

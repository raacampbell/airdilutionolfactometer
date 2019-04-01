function compareLiquidAir

%The liquid dilutions
liquid={'waterVial.mat','etho_1in1000',...
        'etho_1in100','etho_1in10',...
        'etho_pure'};
concs=[0,1e-3,1e-2,1e-1,1];

for ii=1:length(liquid)
  d=load(liquid{ii});
  res(ii)=analyseEthanol(d.out,0);
end

d=load('eth_airdilution');
air=analyseEthanol(d.out,0);


clf, hold on
col=jet(length(liquid));
for ii=1:length(liquid)
  
  f0=find(res(ii).flow==0);
  plot(repmat(0,length(f0),1),res(ii).deltaF(f0),...
       'o','color',col(ii,:));

  f25=find(res(ii).flow==0.25);
  plot(repmat(concs(ii),length(f25),1),res(ii).deltaF(f25),...
       'o','color',col(ii,:));

end

plot(air.flow*4,air.deltaF,'*k')


hold off

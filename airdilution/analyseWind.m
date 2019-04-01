function analyseWind(data)

  
baselineEndIndex=round(data(1).delay*data(1).sr);
responseStartIndex=round((5+data(1).delay)*data(1).sr);
for ii=1:length(data);

    baseline=data(ii).data(1:baselineEndIndex);    
    baseline=mean(baseline);
    response=data(ii).data(responseStartIndex:end);
    response=mean(response);

    deltaF(ii)=(response-baseline);%/baseline;
end



clf
subplot(1,2,1)
col=jet(length(data)+1);
hold on

for ii=1:length(data)
  x=(0:length(data(ii).data)-1)/data(ii).sr;
  plot(x,smooth(data(ii).data,data(ii).sr/10),'-','color',col(ii,:))
end
plot([x(baselineEndIndex),x(baselineEndIndex)],ylim,'--k')
plot([x(responseStartIndex),x(responseStartIndex)],ylim,'--r')
hold off
box on
xlabel('Time [s]')
ylabel('Signal amplitude')

subplot(1,2,2)
plot([data(:).flow],deltaF,'ok')
xlabel('Mass flow (l/min)')
ylabel('Signal amplitude')
stats=addFitLine;

title(sprintf('b_0=%1.2e (%1.2e); b_1=%1.2e (%1.2e)',...
              stats.b(1), abs(diff(stats.bint(1,:))),...
              stats.b(2), abs(diff(stats.bint(2,:)))))

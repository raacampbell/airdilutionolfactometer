function results=analyseEthanol(data,doPlot)

if nargin<2 
  doPlot=1;
end

  
baselineEndIndex=round(data(1).delay*data(1).sr);
responseStartIndex=round((0.5+data(1).delay)*data(1).sr);

for ii=1:length(data);

    baseline=data(ii).data(1:baselineEndIndex);    
    baseline=mean(baseline);
    response=data(ii).data(responseStartIndex:end);
    response=mean(response);

    deltaF(ii)=(response-baseline);%/baseline;
    if length(data(1).flow)==2
      flow=reshape([data.flow],2,length(data))';
    else
      flow=[data.flow]';
    end
    
end



if doPlot
  cla
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
    plot(flow(:,1),deltaF,'ok')
    xlabel('Mass flow (l/min)')
    ylabel('Signal amplitude')
    stats=addFitLine;
end



%Return results. 
if nargout==1
  results.deltaF=deltaF;
  results.flow=flow(:,1)';
  results.stats=stats;
  varargout{1}=results;
end

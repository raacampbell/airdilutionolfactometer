function plotFlowMatrix(data)
  
  
    
baselineEndIndex=round(data(1).delay*data(1).sr);
responseStartIndex=round((5+data(1).delay)*data(1).sr);

for ii=1:length(data);

    baseline=data(ii).data(1:baselineEndIndex);    
    baseline=mean(baseline);
    response=data(ii).data(responseStartIndex:end);
    response=mean(response);

    deltaF(ii)=(response-baseline);
    flow=reshape([data.flow],2,length(data))';
end


%Calculate the number of plots
carriers=unique(flow(:,2));

sp=numSubplots(length(carriers)+1);

clf

cCol=hsv(length(carriers)+1);
for c=1:length(carriers)    
  subplot(sp(1),sp(2),c)
  
  f=find(flow(:,2)==carriers(c));
  col=jet(length(f)+1);
  
  hold on
  
  for ii=1:length(f)      
    ind=f(ii);
    x=(0:length(data(ind).data)-1)/data(ind).sr;
    plot(x,smooth(data(ind).data,data(ind).sr/10),'-','color', ...
         col(ii,:))
  end
  
  plot([x(baselineEndIndex),x(baselineEndIndex)],ylim,'--k')
  plot([x(responseStartIndex),x(responseStartIndex)],ylim,'--r')
  
  hold off
  box on
  xlabel('Time [s]')
  ylabel('Signal amplitude')
  title(sprintf('carrier: %0.2g',carriers(c)))


  %Now add points to summary plot
  subplot(sp(1),sp(2),length(carriers)+1)
  hold on
  plot(flow(f,1),deltaF(f),'o','color',cCol(c,:))
  xlabel('Mass flow (l/min)')
  ylabel('Signal amplitude')
  hold off
  legend(mat2str(carriers))
  box on
end



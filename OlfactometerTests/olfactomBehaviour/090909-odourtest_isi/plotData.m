function plotData(data)
  

%These odours were presented
odours=data.odourNames(data.odours);
odours={odours.odour};

stimuli=unique(odours);


side=ceil(sqrt(length(stimuli)));


set(gcf,'DefaultAxesColorOrder',jet(8))
clf
for i=1:length(stimuli)

  subplot(side,side,i)
  ind=strmatch(stimuli{i},odours);

  x=[data.pidDataTimeStamps{ind}];

  y=[data.pidData{ind}];
  y=cleanY(y);

  plot(x,y)

  title(stimuli{i})
  xlim([3,max(x(:))])

  YL=ylim;
  ylim([min(y(:)),YL(2)])
  ylim([0,0.25])  
  set(gca,'color',ones(1,3)*0.5)
  
end




function y=cleanY(y)
  
  for n=1:size(y,2)
    y(:,n)=smooth(y(:,n),10);
  end
  


  

function analyseValveTransient(data)
  
flows=unique([data.flow]);


clf

if sum(isnan(flows))>0
  tap=1;
  flows(isnan(flows))=[];
else
  tap=0;
end

sp=numSubplots(length(flows)+tap);

for ii=1:length(flows)
  subplot(sp(1),sp(2),ii)
  cla
  f=find([data.flow]==flows(ii));
  
  plotDat=[data(f).data];
  for kk=1:length(f)
    plotDat(:,kk)=smooth(plotDat(:,kk),100);
  end
  

  s=shadedErrorBar([],plotDat',{@mean,@std},'-b');
  title(flows(ii))
end


if tap  
  subplot(sp(1),sp(2),ii+1)
  f=find(isnan([data.flow]));
  plotDat=[data(f).data];
  for kk=1:length(f)
    plotDat(:,kk)=smooth(plotDat(:,kk),100);
  end
  

  s=shadedErrorBar([],plotDat',{@mean,@std},'-b');
  title('tap')
end
  

makeAxesEqual


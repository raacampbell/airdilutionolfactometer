function out=measureFlowSpeed(AC)
%  function measureFlowSpeed(AC)
%
% Measure wind speed using hot wire anemometer and valve switching
% Also analyse if AC is a matrix (i.e. if AC is out;  

cla  
if isnumeric(AC)
  analyseData(AC);
  return
end

%Otherwise acquire the data
NI = analoginput('nidaq','Dev1');
addchannel(NI,0);
SR=1e4;
set(NI,'samplerate',SR,'SamplesPerTrigger',SR*1);

setFlow(AC,1,'D'); %1 SLPM through 

  
%flows=[0.035:0.0025:0.07];
flows=0.7:0.01:0.85;
flipFinal(1)
P=0.05;

out=nan(length(flows),1);

hold on
xlim([min(flows),max(flows)]);
for ii=1:length(flows)
  setFlow(AC,flows(ii),'A');
  pause(0.5)
  start(NI)
  data=getdata(NI);
  out(ii)=mean(data);
  plot(flows(ii),out(ii),'k.')
  drawnow
end
flipFinal(0)


setFlow(AC,0,'A');
out=[flows(:),out];

pause(1)
start(NI)
data=getdata(NI);
out(end+1,2)=mean(data);
out(end,1)=nan;

plot(xlim,[out(end,2),out(end,2)],'--r')
drawnow

hold off

measureFlowSpeed(out)

function analyseData(data)

  tap=data(end,2);
  data(end,:)=[];
  
  S=smooth(data(:,2));
  S=[interp(data(:,1),5),interp(S,5)];
  

  plot(S(:,1),S(:,2),'-b')
  hold on
  plot(data(:,1),data(:,2),'.k')
  plot(xlim,[tap,tap],'--r')
  hold off

  jj=findNearest(S(:,2),tap);
  title(sprintf('Tap=%0.3f SLPM',S(jj,1)))

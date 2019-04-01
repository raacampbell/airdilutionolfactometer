
function out=concSeries(AC)
% function out=concSeries(AC)
%
% Generate a concentration calibration curve


NI = analoginput('nidaq','Dev2');
addchannel(NI,0);

SR=1e3;


%setFlow(AC,1,'CD');
%setFlow(AC,0,'C');


%flows=[0:0.0025:0.05];
%flows=[0,0.01];
odour=[0,0.01,0.05,0.15,0.3,0.6,0.8,1];
initialiseFlows(AC,odour(1),1);

odourID=1;

reps=1;
delay=6;
n=1;
set(NI,'samplerate',SR,'SamplesPerTrigger',7e3);
for r=1:reps
  if reps>1
    fprintf('** Repeat %d **\n',r)
  end

  for ID=1:length(odourID)
    injectOdour(odourID(ID))
  
    for ii=1:length(odour)

        initialiseFlows(AC,odour(ii),1)
        
        pause(delay)

        start(NI)
        %pause(0.5)
        flipFinal6509
        out(n).odour=odourID(ID);
        out(n).data=getdata(NI);
        out(n).flow=odour(ii);
        out(n).sr=SR;
        out(n).delay=delay;
        n=n+1;
        flipFinal6509
    end
    
    injectOdour(odourID(ID))
  end
  
end

stop(NI)
delete(NI)

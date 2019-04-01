
function out=calibrationCurve(AC)
% function out=calibrationCurve(AC)
%
% Generate a concentration calibration curve


NI = analoginput('nidaq','Dev2');
addchannel(NI,0);

SR=1e3;
set(NI,'samplerate',SR,'SamplesPerTrigger',10e3);

setFlow(AC,1,'CD');
%setFlow(AC,0,'C');


%flows=[0:0.0025:0.05];
%flows=[0,0.01];
odour=[0,0.001,0.005,0.01,0.05,0.1,0.3,0.6];
initialiseFlows(AC,odour(1));

reps=4;
delay=6;
n=1;
for r=1:reps
  if reps>1
    fprintf('** Repeat %d **\n',r)
  end
  
    for ii=1:length(odour)
        initialiseFlows(AC,odour(ii))
        
        pause(delay)
        start(NI)

        out(n).data=getdata(NI);
        out(n).flow=odour(ii);
        out(n).sr=SR;
        out(n).delay=delay;
        n=n+1;
    end
end

stop(NI)
delete(NI)


function out=recordThingy(AC)

NI = analoginput('nidaq','Dev1');
addchannel(NI,0);

SR=1e3;
set(NI,'samplerate',SR,'SamplesPerTrigger',20e3);

setFlow(AC,1,'CD');
%setFlow(AC,0,'C');


%flows=[0:0.0025:0.05];
%flows=[0,0.01];
flowC=[0,0.25/10,0.25/100];
flowD=[0.25,0.25,0.25]-flowC;
reps=10;
delay=2.5;
n=1;
for r=1:reps
  if reps>1
    fprintf('** Repeat %d **\n',r)
  end
  
    for ii=1:length(flowC)
%        fprintf('%d/%d - flow=%0.2g\n',ii,length(flows),flows(ii))

        setFlow(AC,0,'C')
        setFlow(AC,0.25,'D')
        
        pause(delay)
        start(NI)
        pause(2.5)
        setFlow(AC,flowC(ii),'C')
        setFlow(AC,flowD(ii),'D')

        out(n).data=getdata(NI);
        out(n).flow=flowC(ii);
%        out(n).flow=flows(ii);
        out(n).flow=[flowC(ii),flowD(ii)];
        out(n).sr=SR;
        out(n).delay=delay;
        n=n+1;
    end
end

stop(NI)
delete(NI)
setFlow(AC,0,'CD');

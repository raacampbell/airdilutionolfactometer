function out=flowMeasure(AC)

NI = analoginput('nidaq','Dev2');
addchannel(NI,1);
SR=1e4;


delay=1;

flow=0.1:0.1:1;

set(NI,'samplerate',SR,...
       'SamplesPerTrigger',SR*4);


setFlow(AC,0,'A');
out=[];
for ii=1:length(flow)

  start(NI)
  pause(delay)
  setFlow(AC,flow(ii),'A');
  pause(3)
  fprintf(AC,'G');tmp=readFM(AC);
  out=[out;flow(ii),tmp.volumetricFlow,mean(getdata(NI))];

end


setFlow(AC,0,'A');

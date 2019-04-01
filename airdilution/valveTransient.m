function out=valveTransient(AC)
  
  
NI = analoginput('nidaq','Dev1');
addchannel(NI,0);

SR=1e3;
set(NI,'samplerate',SR,'SamplesPerTrigger',10e3);



flows=[0,0.01,0.025,0.05,0.1,0.15,0.2];
reps=4;
delay=5;
n=1;

setFlow(AC,1,'D')
for ii=1:length(flows)

  
   fprintf('%d/%d - flow=%0.3g SLPM ',ii,length(flows),flows(ii))

  for R=1:reps

    fprintf('.')
    flipFinal(1)
    start(NI)
    pause(delay)
    setFlow(AC,flows(ii),'A'), pause(5.5)
%    putvalue(dio.line(3),1), pause(1), putvalue(dio.line(3),0), pause(1)
    setFlow(AC,0,'A')
    pause(0.5)
    flipFinal(0)
    
    out(n).data=getdata(NI);
    out(n).flow=flows(ii);
    out(n).sr=SR;
    out(n).delay=delay;
    n=n+1;


  end
  fprintf('\n')
end


setFlow(AC,0,'A')

%Now present flow through the tap
fprintf('Doing tap reps ')
for R=1:reps
  fprintf('.')
  flipFinal(1)
  start(NI)
  pause(delay)
  flipFinal(0), pause(5.5), flipFinal(1)
 
  
  
  out(n).data=getdata(NI);
  out(n).flow=nan;
  out(n).sr=SR;
  out(n).delay=delay;
  n=n+1;

end
fprintf('\n')


flipFinal(0)
setFlow(AC,0,'D')

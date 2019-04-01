function data=measureRobo(reps)
% function data=measureRobo(reps)
%
% Purpose
% Present odours through the robo-trainer (pushing air through it rather 
% than sucking) whilst recording responses with the PID. 
%


SR=1e3;
NIDAQ = analoginput('nidaq','dev2');
set(NIDAQ,'SampleRate',SR);
addchannel(NIDAQ,0);

blockLength=18;
set(NIDAQ,'SamplesPerTrigger',SR*blockLength)

flipLine6509(39,1) %open clean air
flipLine6509([41,43],0) %shut all
disp('open tap and press return')
pause

for ii=1:reps

    fprintf('Rep %d/%d: ',ii,reps)
    %record Oct
    fprintf('Octanol ')
    flipLine6509([41,39])
    start(NIDAQ)
    data(ii).oct=getdata(NIDAQ); 
    flipLine6509([41,39])
    pause(1)
    
    %record MCH
    fprintf(',MCH ')
    flipLine6509([43,39])
    start(NIDAQ)
    data(ii).mch=getdata(NIDAQ); 
    flipLine6509([43,39])
    pause(1)

    
    fprintf(',air')
    pause(10)
    start(NIDAQ)
    data(ii).air=getdata(NIDAQ); 
    fprintf('\n')       
end

disp('close tap and press return')
pause
flipLine6509([41,43,39],0) %open octanol



function data=RecordPID2
% function RecordPID2

% Present odours using the home-brew olfactometer 
% and acquires PID traces. 

% Within Prairie View:
% We'll use t-series to do the odour presentations one line per presentation.
% The reps should be appropriate for the time it takes for the Matlab loop
% to run. Check "trigger cycle"

NIDAQ = analoginput('nidaq',1);

SR=1e3;
set(NIDAQ,'SampleRate',SR,'SamplesPerTrigger',SR*12);
addchannel(NIDAQ,3)

odourValves=1:32;
odourValves([1,4])=[]; %Get rid of the control vials

params.control=4;
params.duration=1;

reps=1;
odours=[];
for i=1:reps
    odours=[odours,odourValves(randperm(length(odourValves)))];
end

%We will make a record of which vials were open when
filestr=['Odours_',datestr(now,'HHMMSS'),'.csv'];
fid=fopen(filestr,'w');


%De-pressurise the system through the control vials
flipFinal('prepare')
flipValve(params.control,1);pause(3)

ISI=16;
params.isi=ISI;
flipFinal_4('prepare')
pause(5)

for i=1:length(odours)-1
    params.odour=odours(i);

    printString=sprintf('%d/%d, %s, vial:%d',...
        i,length(odours)-1,datestr(now,'HH:MM:SS'),params.odour);
    disp(printString)
    fwrite(fid,[printString,'\n']);
    
    start(NIDAQ) %the trigger
    presentOdour(params);

    data{i}=getdata(NIDAQ);

    subplot(5,6,i)
    plot(data{i})
    title(odours(i))
    xlim([7*SR 11*SR])

end
    
    
flipFinal_4('Clean')
shutAllValves; %Shuts everything
disp('Done!')
fclose(fid);
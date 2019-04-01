
function out=recordFlowMatrix(AC)

%record responses to a range of flow rate combinations
out=struct;
NI = analoginput('nidaq','Dev1');
addchannel(NI,0);

SR=1e3;
set(NI,'samplerate',SR,'SamplesPerTrigger',12.5e3);



dio=digitalio('nidaq','dev1');
hwlines = addline(dio,0:3,'out');



%flows=[0:0.0025:0.05];
%flows=[0,0.01];

flowC=[0.2,0.175,0.125,0.1,0.075,0.05,0.025,0.01]; %the range of air dilutions to use
flowC=[0.1,0.075,0.05,0.04,0.03]; %The range of carrier flow rates
flowD=[1]; %The range of carrier flow rates

delay=2.5;
n=1;
reps=10;

for R=1:reps
N=length(flowD)*length(flowC);
for C=1:length(flowC)
    for ii=1:length(flowD)
        %Calculate the dilution
        MFC_C = flowD(ii) * flowC(C);
        MFC_D = flowD(ii) - MFC_C;

        fprintf('%d/%d - carrier=%0.3g; odour dilution=%0.3g\n',n,N*reps,...
                flowD(ii),flowC(C))


        setFlow(AC,MFC_C,'C')
        setFlow(AC,MFC_D,'D')
        flipValveTmp(dio,'clean')
        pause(delay)
        start(NI)
        pause(2.5)


        flipValveTmp(dio,'odour')

        out(n).data=getdata(NI);
        out(n).flow=[flowC(C),flowD(ii)];
        out(n).sr=SR;
        out(n).delay=delay;
        n=n+1;
    end
end
end

setFlow(AC,0,'CD')
putvalue(dio.line(1:4),0)  

stop(NI)
delete(NI)
delete(dio)





function out=simpleOdourTest(AC)
%  function simpleOdourTest(AC)
%
% Present odour through one vial on the new odour delivery system
% and gate it with the final valve.
%
% If AC is a structure, we plot the data

clf
if isstruct(AC)
    out=plotData(AC);
    return
end

%The first dilution will be a 1:20 mixture
setFlow(AC,1,'A')

delay=6;
%odourConc=[0.6, 0.5, 0.4,0.3];
odourConc=[0.025,0.01,0.008,0.005,0.002];
odourConc=10.^(-0.3:-0.25:-2.4)'; %so it's even on a log scale
dur=repmat(12,1,length(odourConc));
offSet=5;

NI = analoginput('nidaq','Dev2');
addchannel(NI,0);
SR=1e4;


%flipFinal(1)


ns=numSubplots(length(odourConc));
flipValve(11,1)
for ii=1:length(odourConc)
    
%     setFlow(AC,1-odourConc(ii),'A')
%     setFlow(AC,odourConc(ii),'B')
%     
    set(NI,'samplerate',SR,...
        'SamplesPerTrigger',SR*(delay+dur(ii)+offSet));
    
    start(NI)
    
    pause(delay)
    %open line and then switch on flow
    fprintf('Conc: %0.3f\n',odourConc(ii))
    
    flipValve(4,1),flipValve(11,0);
     setFlow(AC,1-odourConc(ii),'A')
     setFlow(AC,odourConc(ii),'B')
     
    %  pause(delay)
    %  flipFinal(0)
    pause(dur(ii))
    %  flipFinal(1)
    
    flipValve(4,0),flipValve(11,1)
     setFlow(AC,1,'A')
     setFlow(AC,0,'B')
    
    out(ii).data=getdata(NI);
    out(ii).duration=dur(ii);
    out(ii).delay=delay;
    out(ii).offSet=offSet;
    out(ii).sr=SR;
    out(ii).odourConc=odourConc(ii);
    
    subplot(ns(1),ns(2),ii)
    plot(out(ii).data,'-k')
    drawnow
end


setFlow(AC,0,'AB')
stop(NI)
delete(NI)
%flipFinal(0)
flipValve(1:11,0)

out=plotData(out);

function data=plotData(data)
ns=numSubplots(length(data));
sr=data(1).sr;
extraRows=2;
ns(1)=ns(1)+extraRows;
for ii=1:length(data)
    subplot(ns(1),ns(2),ii)
    d=smooth(data(ii).data,20);
    
    b=floor(sr*(data(ii).delay));
    bl=mean(d(1:b));
    d=d-bl;
    
    resp=([5.4,6.7]*sr)+b;
    t=(0:length(d)-1)*1/sr;
    hold on
    plot(t,d,'-k')
    plot(t(resp(1):resp(2)),d(resp(1):resp(2)),'-r')
    hold off
    title(data(ii).odourConc)
    data(ii).respMag=mean(d(resp(1):resp(2)));
    
    xlim([0,max(t)])
    Y=ylim;
    
    ylim([-diff(Y)*0.05,Y(2)])
    box on
end
labelEdgeSubPlots('time','odour conc')
%makeAxesEqual

ii=ii+ns(2)-mod(ns(2),ii)+1

subplot(ns(1),ns(2),ii:ns(1)*ns(2))

plot(log10([data.odourConc]),[data.respMag],'ok-','markerfacecolor',[1,0.5,0.5])
xlabel('Odour Conc')
ylabel('Response Magnitude')

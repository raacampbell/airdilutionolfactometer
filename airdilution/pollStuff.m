function out=pollStuff(AC,duration)

delay=0.05;
duration=duration/delay;

for ii=1:duration
    fprintf(AC,'D');
    MFC(ii)=readMFC(AC);
    fprintf(AC,'G');
    FM(ii)=readFM(AC);
    pause(delay)       
end

out.MFC=MFC;
out.FM=FM;
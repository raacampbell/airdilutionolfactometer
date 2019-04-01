We are re-designing the odour delivery system to deal with the
problems we've been having. 

Start off by connecting vials 11:2:29 in series. Fill each vial with
5ml of ethanol. Vial 29 is empty. 

Record with no check valves:
params_100323_163943.mat

Record with check valves:
params_100323_173117.mat

There is odour coming out of clean air with the check valve. But we
have just cleaned them with ethanol. 

Next day we do it again. The clean air signal has vastly decresed. The
check valves were sticking. Passing air through at 800 ml/min does
unstick them. However, just playing with the machine it seems that the
PID traces are rather non-stationary. 

Actually, when I run it for 6 reps it looks pretty good.  The only
issue is that sometimes the odour presentation is delayed by 500 ms
(happened 1/60 in this case) due to the flow controller signal being
delayed.

There is some non-stationarity and I generally notice a trend for
larger responses later on in time. 

Replace check valve at 25 and run again (but with slightly faster ISI
and no empty vial): params_100324_125249.mat

Looks better, but the build-up of concentration is a problem. 


Let's try once more, having had the system quiet for 40 minutes.
Still bad. About as bad as before.  params_100324_133823


Now we apply two changes. 
1. Keep MFC switched on the whole time and flip between the empty and
odourised vial. The PID signal does go up when I use the empty vial,
but I don't smell anything. 

2. Vial 13 now has a PTFE tube that goes most of the way down to the
liquid. I am experimenting to see if this results in more stationary
performance. 

Run two of these with a 20 minute interval.
Signals are also smaller. But it's not clear why that would be. 
params_100324_140642.mat
params_100324_143634.mat

PID went to e-room. Dropped head (OUCH) but it's still
working. params_100324_161131.mat
Ooh fuck. Now it's clipping. I had cleaned it, actually. 

Run it again...
params_100324_170457.mat (gain settings are lower)
This time we deliver a 0.5 s pulse at 800 ml/min about 5 s before the
"true" odour pulse. Let's see if this makes things better. Yes, it
does make things better. I'm starting to suspect these weird delays
are due to the checkvalves because you see them less with a higher
flow rate. 



25/03/2010

params_100325_125504 
Set gain to x5 and bubble air through ethanol in tube 13. 
Bubbling air through the ethanol at 200 ml/min doesn't seem to cause
crap to fly around everywhere. This is because the flow rate is low
and we're not allowing pressure to build up. The signal is much higher
from this vial but not clipping PID. We run x5 and see if it's
reproducible. 

I don't know why, but vial 27 is producing a much larger signal than
the others. 


Now run 10 seconds of odour through each vial to see how flat the
response is. I have set the PID gain to 1x, otherwise the signal
saturates the amp for some vials. 
params_100325_144139


It's too erratic. So I set up the old final valve with just the last
pair of valves. One is odour one is clean air. The OFF step is brought
about by the vial switching off so that the whole system cleans out. 
params_100325_161650.mat doesn't look too bad

Fiddled with the code a bit. Noticed that flow through the vial goes
down when we're routing it through the valve. Repeated it again and it
looks really awful but I don't know why. 
params_100325_164606.mat



26/03
Ok ,it looks like the small diameter of the final valves (1/16th inch)
means that the check valves don't open right. 
I have put an old, crappy, check into V13 where we're bubbling. 
Bubble at 0.5 L/min for 3 secs then down to 0.2 then present. Also,
I'd bubbled extensively through that vial before for testing. Looks
awesomely good:
load params_100326_131251.mat

Now wait two hours and run it again:
It took params_100326_151344.mat
The first two stimulus presentations are higher than the rest so the
system does take a little time to equilibrate. 

Wait half an hour and we get the same problem. 
params_100326_154004.mat

I increased the time over which we bubble at a higher rate and that
has increased variance. 
params_100326_162803.mat
params_100326_163150.mat



Looking better now that I set pre-presentation bubbling to 0.4
params_100326_165043.mat


Better still now that I bubble through each vial for 10s before we
 start the presentation regime. I think the freaky blue dip is just
 chance. 
 params_100326_165043.mat



Fill V13 1/10 with ethanol and run it 15 times to see what it looks
like. 
Eeek. It clearly hasn't equilibrated yet. I also forgot to vortex it. 
params_100326_171154.mat
First rep was at 1x gain. 


Will vortex and try again. 
params_100326_172130.mat
That's no better. It's still going down. 

longer ISI may have improved things. I wonder if with a diluted odour
I shouldn't be bubbling for as long. Try thath. 
load params_100326_180042.mat


Looking at the PID trace, it seems that 1s at 0.4 ml/min is enough to
increase the odour concentration to where it ought to be. So we do 1s
at 0.4 then go down to 0.25 (which is where most of today has been
done) to present the odour to the fly. 

The concentration is just more stable when we're dealing with pure
odour. As soon as you dilute it then it starts to run down. This is
because the vapour pressure decreases. With pure odour that can't
happen. Go back to pure odour, I think!



27/3
Could it be that diluting at 1:1000 will improve the problem?
params_100327_154706.mat
params_100327_160249.mat
No, it still goes down at every presentation. What's worse is that we see the
higher level of the odour valve to be more a problem. I'll pull apart
the tubing there and see if I can clean it. 

One last possibility: What if it takes it overnight to equilibrate?
Try the 1:10 again. No, quite the oposite: params_100327_161423.mat


28/3
I had noticed that the stream from the vials had a higher resting PID
value than the clean air stream. Vial 13 was attached to an old style
valve and a 1/1000 ethanol vial. When I replaced this vial with one
containing an essential oil on cotton wool, the basal PID signal
decreased. It looks like this higher signal may simply be due to the
odours and can be fixed by the fancy parker valves. Changing the clean
air vial didn't alter anything and placing a clean air vial into the
clean air stream didn't help either. 

Today we won't use the final valve because I'm cleaning the
Y. Instead, we put the PID directly onto the end of the tube coming
from the odour delivery system. 

I then present odour through the essential oil vial so we can evaluate
it for stationarity. 
load params_100328_152704.mat 
PID_tracesByOdour(params,[],[16,18])

load params_100328_153325.mat
PID_tracesByOdour(params,[],[16,18])

We still see concentration drops on each stimulus presentation.   

Now try with the 70/30 OCT/MCH mixture. 
This also goes down. It looks like there'll be no way of avoiding this
unless we use saturated vapour. I think that for non-saturated vapour,
params_100328_155935.mat
params_100328_160854.mat
I'm probably forcing throgh too much air. We'd need to bubble
initially so that we get rid of high-concentration head space. But
then I could probably bubble at just 0.25ml/min for 7 s or so. Try
this next...

It's not run out. 
params_100328_161932.mat


I put the pure ethanol vial back and present a few pulses to check it
out again. Is it really better than the diluted odours?
YES: params_100328_162845.mat

Ok... So can I shove a 1ml/min pulse into the stream and pick it up??
No. It looks like the carrier creates pressure which stops odour from
entering the stream. If the difference between the streams is more
than about 1/10, we get a problem. 


29th March
We have decided to run the oct/mch experiment using
dilutions. Firstly, I will run ethanol though all vials and choose 6
which are best matched. Secondly, then I equalise the intensity of the
MCH and Octanol with the T-maze. I will also see if using a large
volume of liquid works better than a small volume. I.e. a more stable
trace can be obtained this way. 

Ok. We try to present each 5 times. This is 50 reps but the data
acquisition seems to have halted at 34, for some odd reason. Try to
work out why. Ah! It's because I started PV!  Before each of the
following I'm bubbling at 0.5 ml/min for 10 s through each vial in
turn and then begining the acquisition. 


Ok:
params_100329_122851.mat
I'm having troubling getting valve 15 to open. 
Will try blasting with 0.4 ml/min for 2 seconds before droping to
0.25. If that doesn't work, I'll just see if I can do it all at
.25. Probably have to anyway, since I think we'll need a high flow
rate to get the t-maze concentrations. 
No, this didn't work either: params_100329_132054.mat

So I will try presenting the odours at 0.4 ml/min

It's nicer and more consistent at 0.4. 
params_100329_134328

I'll run more at 0.5 but will only run those vials that look fairly
similar to eachother: 11,13,19,21,23,27
params_100329_140034: ok, but 27 is too high. Replace it with 17 and
see how that goes
params_100329_143349.mat

It's not as stable as it was before. I've not been bubbling. So repeat
it but bubble this time. 

params_100329_163902.mat Still goes down over time. 
It's also lower than the values we got without bubbling. Argh!


Run it once more because I want to see whether the signal becomes
lower than the last. 
save params_100329_172731.mat


Shit, the signal is going down.  For all vials. 
Let's present x5 from 17 and another vial which hasn't been much used
recently: 27

Everything's going down (params_100329_175103.mat) since 27, which
I've not been using, is also low now. I think it's the PID....
Let's clean it and try again

Yeah, fuck. That was it! So maybe the Oct/MCH wasn't really running
down after all? 
params_100329_181309.mat (no flushing)

Let's re-run what we were doing before. 
params_100329_182227

I really don't know why I got some consistently high readings before
and not now. No idea. But it does look like the decrease in
sensitivity is due to the PID. At least in this case. 



I'll just do some MCH...
Set PID to x1 and suction to low
Set flow through the vial to 500 ml/min and stick it into #27 with the
old (crappy) check valve and bubble. The MCH was freshly made today. 
params_100329_184718.mat

Sod. The gain had to be at x10, because that's what we used for
e-room. Do it again...

params_100329_185604.mat

This is too low and we're getting a valve switching artefact

TOMORROW:
> Clean PID again. 
Ok. cleaned with line from the wall. Dropped the bulb, but it's not
cracked and the PID lit up straight away. Test with ethanol from 4 of
vials. 6 reps each. Bubbling through each. Odour flow is 0.5/0.5
WHY does it now look so bad? It was stationary before! Try dropping
down to 0.25 ml/min. Yeah... so that looks better. 
params_100330_121140.mat

Try again at 0.2 ml/min but this time flush before hand


> Try it at 900 ml/min (which is what it was in the e-room). 

> Try the Oct and see if the intensity ratio is the same here. 

> Maybe consider increasing the concentration in the tubes?

> Do we have PID measurements from before?
Yes, here: /home/rob/work/Insects/olfactoryStimuli/BubblingTest/
But without knowing whether the PID was clean, they don't count for
much. 

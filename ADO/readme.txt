The ADO is the Air Dilution Olfactometer

We will run some tests to make sure that all is ok. 

20/07
There were some problems with bubbling through the ethanol and glass
beads. I don't know why, but the signal was very weak. I have found
that an odour vial with ethanol at the bottom and no bubbling gives a
much better signal. There is also no problem with stuff being sucked
up the wrong way. A big bonus. I will try to work without bubbling for
now. 

First we want to generate a calibration curve: presenting a range of
different odour concentrations at the first dilution point. We will
just record the signal coming out of the manifolds. 

Save as calib_20072010
It looks like a flow rate of 0.005 (5 ml) is coming through just
fine. 


21/07
Now we want to set up 12 ethanol vials and present odour from each. Do
we see the same response from each vial? We will pick up the signals
straight out of the in-line manifolds without going through the final
valve at all. 

Run at 0.333 odour
params_100721_113906.mat  Vials 8 and 3 are rather different from each
other. It turned out that Vial 8 had the needles connected the wrong
way around (green fat needle at input) and that Vial 3 had a suspect
septum. Now it looks good:
params_100721_123921

now do 0.166 odour so that we can show how small the differences
between vials really are. So the differences between vials really
aren't very important:
params_100721_130233

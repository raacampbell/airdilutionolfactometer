# Air Dilution Olfactometer

This repository is a loose collection of notes and data regarding an air dilution "olfactometer" (odor delivery system) built by me at Cold Spring Harbor in 2010/2011. 
The device was used to image olfactory-evoked neural activity in fruit flies (https://www.ncbi.nlm.nih.gov/pubmed/23785169, https://www.ncbi.nlm.nih.gov/pubmed/21849538) in Glenn Turner's lab. 
Descendants of the device are now used by the Turner lab at Janelia. 
The olfactometer was optimized for producing crisp and fairly square odor stimuli with minimal pressure transient at the sample. 
The design I used had 8 vials plus a clean air control vial. 

I'm afraid the notes in this repository are very disorganised, but at least they are now finally on-line. 
If you have questions, please file an issue (so others can benefit). 
I can potentially upload more information if time permits. 
If you decide to build a similar device, I highly recommend you purchase a PID (see below). 
It's expensive, but you won't know what the olfactometer is really doing unless you measure its output with a PID. 

<img src="https://github.com/raacampbell/airdilutionolfactometer/blob/master/photos/ADO_top.jpg">
<img src="https://github.com/raacampbell/airdilutionolfactometer/blob/master/photos/ADO_side.jpg">


## Glossary
- PID - mini photoionisation detector This device registers the presence of odourants in air. It works by breaking up the molecules, creating ions, then measuring the resulting current through the air. Signal strength varies by odor. 
- MFC - mass flow controller
- robo - the "robotic" fly behaviour training device. This contains three vials: odor a, odor b, and clean air. It's run with high flow through really fat tubes with odors diluted in  oil. It features here because for some experiments we sought to match odor concentrations on the 2-p rig with those from the trainer.
- e-room - The "environment" room where fly behaviour experiments are carried out. 



## Roughly what happened
I first built an odor delivery system with about 20 odor vials based on a design from the Albeanu lab (CSHL). This used vials with oil-diluted odourants. Bubble air through them. Vale on inlet side and check valve on output. The system was problematic because the check valves needed a minimum pressure to open (of course) and so when inlet valves open, pressure builds of a second or so, check valves open, then a violent burst of air flows through the oil. This creates an aerosol that coats the inside of the tubes throughout the device. 

Following this, I rebuilt the whole thing based on hints by Ashesh in India and the Rinberg design from Janelia. I used N-Research zero-dead-space linear valves on the output side. N-research valves as inlets. No more check valves. I stopped using oil dilutions because this requires bubbling and different odours behave differently in oil. I stopped using the septa and needles because they leak (switch to Teflon caps with barbs). I started using serial air dilutions because this allows changes in concentration on the fly and is more consistent. I used Teflon-lined Tygon tubing (flexible) with 1/8" diameter to allow for lower pressure transients at reasonable flows. 

Avoid dumping to vacuum via a hard line to vacuum. Send tube to a funnel that goes to vac. i.e. don't suck actively and create a strong negative pressure. 

The final valve was the shuttle valve. For it to work well the flow to vacuum has to have the same impedance as the other output. If not you get oddly shaped odor pulses. Maybe even double-pulses. We solved this by going to vac via a simple flow-meter with a knob. Could also perhaps have used a tube of the correct length. The latter may have meant no tweaking, but we never tried it. 


## Files in this folder
- flowToVac.txt - how to set up air dilutions with chocked flow using Alicat flow meters
- OlfactomPlan_100527 - the layout of the final olfactometer
- Olfactometer_v11 - design from Rinberg lab
- Ideas.txt - some thoughts after discussing with Ashesh
- Directory "ADO" - "air dilution olfactometer". This contains a directory with some initial test data. See "html" sub-dir for notebook file. The "roboCalibration" folder is my attempt to find an air dilution that matches the oil dilution used in the fly behaviour t-maze. 
- Directory "OlfactometerTests" contains badly organised test information from both the first and second design. Probably most interesting is the sub-dir "newOlfactomDesign_100323" as that describes my initial forays into the new design. 
- folder "olfactomBehaviour" - contains a little data where I'm characterising the behavior of the old design. 


I lack a good characterization of the final design, as once it started working well I began doing experiments. 

## Also see
* [alicat-matlab](https://github.com/raacampbell/alicat-matlab) routines for controlling Alicat flow controllers in MATLAB.

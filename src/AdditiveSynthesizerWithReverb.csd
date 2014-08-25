<CsoundSynthesizer>
<CsOptions>
	-o dac -+rtaudio=null -dm0
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

giSine  ftgen   0, 0, 1024, 10, 1

gaL		init		0
gaR		init		0

turnon 010	;Turn on the Synthesizer
turnon 100	;Turn on the Output

/*********************
	Turn-On
*********************/

instr 001

    event_i "i", p4, 0, 3600
	turnoff

endin

/*********************
	Turn-Off
*********************/

instr 002
    
    turnoff2 p4, 0, 1

endin

/*****************************
	Additive Synthesizer
*****************************/

instr 010

	;Fundamental Information
	kFreq  	chnget  "frequencySlider"
	kAmp    chnget  "amplitudeSlider_0"

	;Harmonic Information
	kAmp1  	chnget  "amplitudeSlider_1"
	kAmp2  	chnget  "amplitudeSlider_2"
	kAmp3   chnget  "amplitudeSlider_3"
	kAmp4   chnget  "amplitudeSlider_4"
	kAmp5   chnget  "amplitudeSlider_5"
	kAmp6   chnget  "amplitudeSlider_6"
	kAmp7   chnget  "amplitudeSlider_7"
	kAmp8	chnget  "amplitudeSlider_8"
	kAmp9	chnget  "amplitudeSlider_9"
	kAmp10	chnget  "amplitudeSlider_10"

	aFund	oscil 	kAmp, kFreq, giSine
	aHarm1	oscil 	kAmp1, kFreq*2, giSine
	aHarm2  oscil 	kAmp2, kFreq*3, giSine
	aHarm3  oscil 	kAmp3, kFreq*4, giSine
	aHarm4  oscil 	kAmp4, kFreq*5, giSine
	aHarm5  oscil 	kAmp5, kFreq*6, giSine
	aHarm6  oscil 	kAmp6, kFreq*7, giSine
	aHarm7  oscil 	kAmp7, kFreq*8, giSine
	aHarm8 	oscil 	kAmp8, kFreq*9, giSine
	aHarm9  oscil 	kAmp9, kFreq*10, giSine
	aHarm10 oscil 	kAmp10, kFreq*11, giSine

	aMix = (aFund + aHarm1 + aHarm2 + aHarm3 + aHarm4 + aHarm5 + aHarm6 + aHarm7 + aHarm8 + aHarm9 + aHarm10) / 11
	gaL = aMix
	gaR = aMix

endin

/*********************
	Reverb
*********************/

instr 020

	kFilterCutoff   chnget  "reverbFilterCutoff"
	kDensity        chnget  "reverbDensity"
	kWetDry         chnget  "reverbMix"

	aLocalL = gaL
	aLocalR = gaR

	aoutL, aoutR reverbsc aLocalL, aLocalR, kDensity, kFilterCutoff	

	aoutL balance aoutL, aLocalL
	aoutR balance aoutR, aLocalR

	aMixL = aLocalL + (aoutL * kWetDry)
	aMixR = aLocalR + (aoutR * kWetDry)

	;Avoid mixing on the global channels for hygiene.
	gaL = aMixL
	gaR = aMixR

endin

/*********************
	Output
*********************/

instr 100
	
	kMasterVolume	chnget	"masterVolume"
	
	gaL = gaL * kMasterVolume
	gaR = gaR * kMasterVolume

	outs	gaL, gaR

	gaL = 0
	gaR = 0

endin


</CsInstruments>
<CsScore>					
</CsScore>
</CsoundSynthesizer>


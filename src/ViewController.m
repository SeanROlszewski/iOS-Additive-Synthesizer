//  Copyright (c) 2012 - 2014 Sean Olszewski. All rights reserved.

#import "ViewController.h"

@implementation ViewController

@synthesize csoundInstance;

#pragma mark Memory Warnings
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    @autoreleasepool {
        self.csoundInstance = [[CsoundObj alloc] init];
    }
    NSString *csdFilePath = [[NSBundle mainBundle] pathForResource:@"AdditiveSynthesizerWithReverb" ofType:@"csd"];
	
	[self.csoundInstance addCompletionListener: self];
    [self.csoundInstance startCsound: csdFilePath];
    [self.csoundInstance muteCsound]; // Start Csound then mute it so if an effect is on before the synth, we still hear the effect when the synth starts.
    
	[self initializeKnobProperties]; // Since we made a custom knob class for this view, initialize all the knob values that we need for it to function properly.
	[self initializeGlobalControls];
	[self initializeAdditiveSynthesizerControls];
	[self initializeReverbControls];
}

- (void)initializeKnobProperties {
    masterGain.minimumValue = 0.0f;
    masterGain.maximumValue = 3.0f;
    masterGain.value        = 0.5f;
    
    reverbDamping.minimumValue = 250.0f;
    reverbDamping.maximumValue = 5000.0f;
    reverbDamping.value = 100.0f;
    
    reverbDensity.minimumValue = 0.0f;
    reverbDensity.maximumValue = 1.0f;
    reverbDensity.value        = 0.5f;
    
    reverbMix.minimumValue     = 0.0f;
    reverbMix.maximumValue     = 1.0f;
    reverbMix.value            = 0.5f;
}

- (void)initializeGlobalControls {
	[self.csoundInstance addKnob: masterGain
				  forChannelName: @"masterVolume"];
}

-(void)initializeAdditiveSynthesizerControls {
	[onOffSwitch setOn: NO animated: NO];
	
	[self.csoundInstance addSlider:      frequencySlider
					forChannelName:      @"frequencySlider"];
	[self.csoundInstance addSlider:      amplitudeSlider_0
					forChannelName: 	 @"amplitudeSlider_0"];
	[self.csoundInstance addSlider:      amplitudeSlider_1
					forChannelName: 	 @"amplitudeSlider_1"];
	[self.csoundInstance addSlider:      amplitudeSlider_2
					forChannelName: 	 @"amplitudeSlider_2"];
	[self.csoundInstance addSlider:      amplitudeSlider_3
					forChannelName: 	 @"amplitudeSlider_3"];
	[self.csoundInstance addSlider:      amplitudeSlider_4
					forChannelName: 	 @"amplitudeSlider_4"];
	[self.csoundInstance addSlider:      amplitudeSlider_5
					forChannelName: 	 @"amplitudeSlider_5"];
	[self.csoundInstance addSlider:      amplitudeSlider_6
					forChannelName:	 	 @"amplitudeSlider_6"];
	[self.csoundInstance addSlider:      amplitudeSlider_7
					forChannelName: 	 @"amplitudeSlider_7"];
	[self.csoundInstance addSlider:      amplitudeSlider_8
					forChannelName: 	 @"amplitudeSlider_8"];
	[self.csoundInstance addSlider:      amplitudeSlider_9
					forChannelName: 	 @"amplitudeSlider_9"];
	[self.csoundInstance addSlider:      amplitudeSlider_10
					forChannelName: 	 @"amplitudeSlider_10"];
}

- (void)initializeReverbControls {
	[reverbToggle setOn: NO animated: NO];
    [self.csoundInstance addKnob:        reverbDamping
				  forChannelName: 		 @"reverbFilterCutoff"];
    [self.csoundInstance addKnob:        reverbDensity
				  forChannelName: 		 @"reverbDensity"];
    [self.csoundInstance addKnob:        reverbMix
				  forChannelName: 	  	 @"reverbMix"];
}

#pragma mark View Changing Methods
-(IBAction)toggleOnOff:(id)toggleSwitch {
    UISwitch *localSwitch = (UISwitch*)toggleSwitch;
	
    if(localSwitch.on)
        [self.csoundInstance unmuteCsound];
	else
        [self.csoundInstance muteCsound];
}

- (IBAction) toggleReverb: (UISwitch *)toggle {
    float turnOnPValues[] = {001.0, 0.0, 1, 020.0};
	float turnOffPValues[] = {002.0, 0.0, 1, 020.0};
	
	// Csound uses a messaging system called score events
	// to cause real-time changes to the sound.
    if(toggle.isOn) {
        [self.csoundInstance sendScoreEvent: 'i'
                             withPFieldValues: turnOnPValues
                             forNumberPFields: 4]; // P-Fields = function arguments.
    } else if(!toggle.isOn) {
        [self.csoundInstance sendScoreEvent: 'i'
                             withPFieldValues: turnOffPValues
                             forNumberPFields: 4];
    }
}

#pragma mark Csound Listener Object Methods
- (void) csoundObjDidStart: (CsoundObj*)csoundObj
	{}

- (void) csoundObjComplete: (CsoundObj*)csoundObj {
    [self.csoundInstance stopCsound];
	[onOffSwitch setOn: NO animated: YES];
}

@end

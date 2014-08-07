//  Copyright (c) 2012 - 2014 Sean Olszewski. All rights reserved.

#import <UIKit/UIKit.h>
#import "CsoundObj.h"

@interface ViewController : UIViewController <CsoundObjCompletionListener> {
	
	// Global Controls
    IBOutlet   UISwitch *onOffSwitch;
    IBOutlet    UIKnob  *masterGain;
	
	// Additive Synthesizer Controls
	IBOutlet   UISlider *frequencySlider;
	IBOutlet   UISlider *amplitudeSlider_0;
	IBOutlet   UISlider *amplitudeSlider_1;
	IBOutlet   UISlider *amplitudeSlider_2;
	IBOutlet   UISlider *amplitudeSlider_3;
	IBOutlet   UISlider *amplitudeSlider_4;
	IBOutlet   UISlider *amplitudeSlider_5;
	IBOutlet   UISlider *amplitudeSlider_6;
	IBOutlet   UISlider *amplitudeSlider_7;
	IBOutlet   UISlider *amplitudeSlider_8;
	IBOutlet   UISlider *amplitudeSlider_9;
	IBOutlet   UISlider *amplitudeSlider_10;
	
	// Reverb Controls
    IBOutlet   UISwitch *reverbToggle;
    IBOutlet   UIKnob  *reverbDamping;
    IBOutlet   UIKnob  *reverbDensity;
    IBOutlet   UIKnob  *reverbMix;

}

@property (nonatomic, assign) CsoundObj *csoundInstance;

- (IBAction)toggleOnOff: (id)toggleSwitch;
- (IBAction)toggleReverb: (UISwitch *)reverbToggle;
- (void)initializeKnobProperties;
- (void)initializeGlobalControls;
- (void)initializeAdditiveSynthesizerControls;
- (void)initializeReverbControls;
@end

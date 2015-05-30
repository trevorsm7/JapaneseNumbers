//
//  AppDelegate.h
//  CocoaTest
//
//  Created by Trevor Smith on 1/24/14.
//  Copyright (c) 2014 Trevor Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSSpeechSynthesizerDelegate>//, NSSpeechRecognizerDelegate>
{
    NSSpeechSynthesizer *synthesizer;
    NSString *selectedVoice;
    int number;
    int attempts;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *inputField;
@property (assign) IBOutlet NSTextField *answerLabel;
@property (assign) IBOutlet NSPopUpButton *digitSelect;
@property (assign) IBOutlet NSPopUpButton *magnitudeSelect;

- (IBAction)next:(id)sender;

- (void)nextRandom;
- (void)speakNumber;

@end

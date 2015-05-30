//
//  AppDelegate.m
//  CocoaTest
//
//  Created by Trevor Smith on 1/24/14.
//  Copyright (c) 2014 Trevor Smith. All rights reserved.
//

#import "AppDelegate.h"
#import "NSMutableArray+Shuffle.h"
#include <stdlib.h>

@implementation AppDelegate

@synthesize inputField;
@synthesize answerLabel;
@synthesize digitSelect;
@synthesize magnitudeSelect;

- (id)init
{
	self = [super init];
	
	if (self)
	{
		// Create the synthesizer
        synthesizer = [[NSSpeechSynthesizer alloc] init] ;
		//synthesizer = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
		[synthesizer setDelegate:self];
        
        // Find an appropriate voice
        NSArray *voiceList = [NSSpeechSynthesizer availableVoices];
        for (NSString *voice in voiceList)
        {
            NSDictionary *attributes = [NSSpeechSynthesizer attributesForVoice:voice];
            NSString *locale = [attributes valueForKey:NSVoiceLocaleIdentifier];
            
            if ([locale isEqualToString:@"ja_JP"])
            //if ([locale isEqualToString:@"en_AU"])
            {
                NSLog(@"Using voice %@", voice);
                [synthesizer setVoice:voice];
                break;
            }
        }
        
        // Setup speech recognizer
        /*recognizer = [[NSSpeechRecognizer alloc] init];
        NSArray *cmds = [NSArray arrayWithObjects:@"ko", @"ni", @"chi", @"wa", nil];
        [recognizer setCommands:cmds];
        [recognizer setDelegate:self];*/
	}
	
	return self;
}

- (void)nextRandom
{
    int digits = [[digitSelect titleOfSelectedItem] intValue];
    int magnitude = [[magnitudeSelect titleOfSelectedItem] intValue];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:magnitude];
    
    for (int i = 0; i < digits; i++)
        [array addObject:[NSNumber numberWithInt:arc4random_uniform(9) + 1]];
    for (int i = digits; i < magnitude; i++)
        [array addObject:[NSNumber numberWithInt:0]];
    
    [array shuffle];
    
    number = 0;
    for (int i = 0; i < magnitude; i++)
    {
        number *= 10;
        number += [[array lastObject] intValue];
        [array removeLastObject];
    }
    
    attempts = 3;
}

- (void)speakNumber
{
    NSString *text = [NSString stringWithFormat:@"%d", number];
    [synthesizer startSpeakingString:text];
}

- (IBAction)next:(id)sender
{
    if (number == [inputField intValue])
    {
        [answerLabel setStringValue:@"Correct"];
        [self nextRandom];
    }
    else
    {
        NSString *label;
        if (--attempts > 0)
             label = [NSString stringWithFormat:@"Attempts left: %d", attempts];
        else
        {
            label = [NSString stringWithFormat:@"Incorrect: %d", number];
            [self nextRandom];
        }
        [answerLabel setStringValue:label];
    }
    
    [inputField setStringValue:@""];
    [self speakNumber];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self nextRandom];
    [self speakNumber];
}

@end

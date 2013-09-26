//
//  HomeViewController.m
//  Gravity Puzzle
//
//  Created by James Mason on 8/18/13.
//  Copyright (c) 2013 Trinary. All rights reserved.
//

#import "HomeViewController.h"
#import "LevelInterpreter.h"

@interface HomeViewController ()
{
    NSTimer *timer;
    float rotationAngle;
    float rotationRate;
    CGPoint screenSize;
    BOOL isSettingsButtonDepressed;
    BOOL isSoundMuted;
    UIButton *infoButton;
    UIButton *soundButton;
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Read in levels
    LevelInterpreter *levelInterpreter = [[LevelInterpreter alloc] init];
    //NSArray *levelData = [levelInterpreter loadLevelFileFromDisk:(NSInteger)1]; // TODO: Change this from 1 to whatever is most relevant
    NSInteger numberOfLevels = [levelInterpreter numberOfLevels];
    
    // Create CALayer holding galaxy and all solar systems
    CALayer *galaxyLayer = [CALayer layer];
    galaxyLayer.contents = (id) [UIImage imageNamed:@"NewGalaxy_Placeholder.jpg"].CGImage;
    [self.view.layer addSublayer:galaxyLayer];
    galaxyLayer.bounds = CGRectMake(0, 0, self.view.layer.bounds.size.height, self.view.layer.bounds.size.width);
    galaxyLayer.position = CGPointMake(self.view.center.y, self.view.center.x);
    for (int i = 0; i < numberOfLevels; i++) {
        CALayer *solarSystemLayer = [CALayer layer];
        solarSystemLayer.contents = (id) [UIImage imageNamed:@"LevelBubble_Placeholder.png"].CGImage;
        [galaxyLayer insertSublayer:solarSystemLayer above:galaxyLayer];
        solarSystemLayer.bounds = CGRectMake(0, 0, 30, 30);
        
        // Determine the position in the galaxy
        // TODO: Figure out a relevant algorithm for placing these rather than hard coding locations -- or hard code but use pixel - relative screen size converter method
        CGPoint levelPosition;
        switch (i) {
            case 0:
                levelPosition = CGPointMake(100, 240);
                break;
            case 1:
                levelPosition = CGPointMake(120, 140);
                break;
            case 2:
                levelPosition = CGPointMake(400, 140);
                break;
            case 3:
                levelPosition = CGPointMake(300, 100);
                break;
            case 4:
                levelPosition = CGPointMake(250, 200);
                break;
            default:
                break;
        }
        
        solarSystemLayer.position = levelPosition;
    }
    
    // Start galaxy spinning
    rotationAngle = 0.0;
    rotationRate = 1.0;
    timer = [NSTimer scheduledTimerWithTimeInterval:rotationRate target:self selector:@selector(rotateGalaxyLayer:) userInfo:galaxyLayer repeats:YES];
    
    // Make game title
    UILabel *gameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    gameTitleLabel.text = @"Gravity Puzzle";
    gameTitleLabel.font = [UIFont fontWithName:@"Chalkboard SE" size:42.0];
    gameTitleLabel.textColor = [UIColor whiteColor];
    gameTitleLabel.backgroundColor = [UIColor clearColor];
    gameTitleLabel.textAlignment = NSTextAlignmentCenter;
    gameTitleLabel.center = CGPointMake(240, 20);
    [self.view addSubview:gameTitleLabel];
    
    // Create settings button
    screenSize = CGPointMake(self.view.frame.size.height, self.view.frame.size.width);
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.x - 60, screenSize.y - 60, 60, 60)];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"SettingsButton_Placeholder.png"] forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(settingsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    isSettingsButtonDepressed = NO;
    isSoundMuted = NO; // TODO: Check if vibrate button is switched on for default state
    [self.view addSubview:settingsButton];
    
    // Create info button
    infoButton = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.x - 50, screenSize.y - 40 - 60, 40, 40)];
    [infoButton addTarget:self action:@selector(infoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    infoButton.tag = 1;
    infoButton.alpha = 0.0;
    [self.view addSubview:infoButton];
    
    // Create sound button
    soundButton = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.x - 50, screenSize.y - 40 - 40 - 60, 40, 40)];
    [soundButton addTarget:self action:@selector(soundButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    soundButton.tag = 2;
    soundButton.alpha = 0.0;
    [self.view addSubview:soundButton];
}

- (void)rotateGalaxyLayer:(NSTimer *)theTimer
{
    // Retrieve galaxy layer 
    CALayer *galaxyLayer = [theTimer userInfo];
    
    float deltaRotationAngle = rotationAngle + 0.05;
    
    // Setup and execute animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = [NSNumber numberWithFloat:rotationAngle];
    animation.toValue = [NSNumber numberWithFloat:deltaRotationAngle];
    animation.byValue = [NSNumber numberWithFloat:deltaRotationAngle / 10.];
    animation.duration = rotationRate;
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:NO];
    [galaxyLayer addAnimation:animation forKey:@"position"];
    rotationAngle = deltaRotationAngle;
}

- (void)settingsButtonPressed
{
    // Add or remove info and sound buttons
    if (isSettingsButtonDepressed == NO) {
        isSettingsButtonDepressed = YES;
        
        [infoButton setBackgroundImage:[UIImage imageNamed:@"InfoButton_Placeholder.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{infoButton.alpha = 1.0;}
                         completion:nil];
        
        [soundButton setBackgroundImage:[UIImage imageNamed:@"SpeakerButton_Placeholder.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{soundButton.alpha = 1.0;}
                         completion:nil];
    } else {
        isSettingsButtonDepressed = NO;
        for (UIView *subview in [self.view subviews]) {
            if (subview.tag == 1 || subview.tag == 2) {
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options: UIViewAnimationOptionCurveEaseOut
                                 animations:^{subview.alpha = 0.0;}
                                 completion:nil];
            }
        }
    }
}

- (void)infoButtonPressed
{
    
}

- (void)soundButtonPressed
{
    if (isSoundMuted == NO) {
        [soundButton setBackgroundImage:[UIImage imageNamed:@"mute_button.png"] forState:UIControlStateNormal];
        isSoundMuted = YES;
    } else {
        [soundButton setBackgroundImage:[UIImage imageNamed:@"SpeakerButton_Placeholder.png"] forState:UIControlStateNormal];
        isSoundMuted = NO;
    }
}

// Any of the solar systems pressed
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        CGPoint point2 = [self.view.layer convertPoint:point toLayer:self.view.layer.superlayer];
        CALayer *theLayer = [self.view.layer hitTest:point];
        theLayer.opacity = 0.3;
    }

    
    
    
    
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *topLayer = self.view.layer;
    for (CALayer *galaxyLayer in topLayer.sublayers) {
        for (CALayer *solarSystemLayer in galaxyLayer.sublayers) {
            CGPoint solarSystemPositionInGalaxy = [solarSystemLayer position];
            CGPoint solarSystemPositionInView = [solarSystemLayer convertPoint:solarSystemPositionInGalaxy toLayer:topLayer];
            CGPoint point = [[touches anyObject] locationInView:self.view];
            CGPoint point2 = [solarSystemLayer convertPoint:point fromLayer:topLayer];
            if ([solarSystemLayer hitTest:point]) {
                NSLog(@"solarsystem hit point");
            }
            if ([solarSystemLayer hitTest:point2]) {
                NSLog(@"solarsystem hit point");
            }
            solarSystemLayer.opacity = 0.5;
        }
    }

}

# pragma mark - Default code blocks

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

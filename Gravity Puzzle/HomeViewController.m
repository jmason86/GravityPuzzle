//
//  HomeViewController.m
//  Gravity Puzzle
//
//  Created by James Mason on 8/18/13.
//  Copyright (c) 2013 Trinary. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    NSTimer *timer;
    float angle;
}
@end

@implementation HomeViewController

@synthesize galaxyBackgroundImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Read in levels
    LevelInterpreter *levelInterpreter = [[LevelInterpreter alloc] init];
    [levelInterpreter loadLevelFileFromDisk];
    
    // Start galaxy spinning
    angle = 0.0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(rotateGalaxy) userInfo:nil repeats:YES];
}

- (void)rotateGalaxy
{
    galaxyBackgroundImageView.center = CGPointMake(self.view.frame.size.width / 1.18, self.view.frame.size.height / 3.1);
    galaxyBackgroundImageView.transform = CGAffineTransformMakeRotation(angle);
    angle += 0.00004;
    if (angle > 2 * M_PI) {
        angle = 0;
    }
}














- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

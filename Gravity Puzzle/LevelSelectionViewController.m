//
//  LevelSelectionViewController.m
//  Gravity Puzzle
//
//  Created by James Mason on 10/16/13.
//  Copyright (c) 2013 Trinary. All rights reserved.
//

#import "LevelSelectionViewController.h"
#import "LevelInterpreter.h"

@interface LevelSelectionViewController ()

@end

@implementation LevelSelectionViewController

@synthesize numberOfLevels;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Place a sun image at the center
    UIImage *sunImage = [UIImage imageNamed:@"Sun_Placeholder.png"];
    UIImageView *sunImageView = [[UIImageView alloc] initWithImage:sunImage];
    sunImageView.bounds = CGRectMake(0, 0, 100, 100);
    sunImageView.center = self.view.center;
    [self.view addSubview:sunImageView];
    
    // Create an orbit image for every level
    float orbitDiameterMultiplier = 0.9;
    for (int i = 0; i < numberOfLevels; i++) {
        UIImage *orbitImage = [UIImage imageNamed:@"Orbit_Placeholder.png"];
        UIImageView *orbitImageView = [[UIImageView alloc] initWithImage:orbitImage];
        orbitImageView.bounds = CGRectMake(0, 0, self.view.bounds.size.width * orbitDiameterMultiplier, self.view.bounds.size.height * orbitDiameterMultiplier);
        orbitImageView.center = self.view.center;
        [self.view addSubview:orbitImageView];
        orbitDiameterMultiplier -= 0.1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    LevelInterpreter *levelInterpreter = [[LevelInterpreter alloc] init];
    NSArray *levelData = [levelInterpreter loadLevelFileFromDisk:(NSInteger)1]; // TODO: Change this from 1 to whatever is most relevant, then pass info to levelViewController
}

@end

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
{
    NSArray *levelObjectImageNames;
}

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
    levelObjectImageNames = [NSArray arrayWithObjects:@"Asteroid_Placeholder.png", @"Earth_PlaceHolder.png", @"Planet1_Placeholder.png", @"Planet2_Placeholder.png", @"SpaceStation_Placeholder.png", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Label for level selection view
    UILabel *levelSelectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    levelSelectionTitleLabel.text = @"Proxima Centauri"; // TODO: Make this name a variable either determined by a file or an internally defined array of names
    levelSelectionTitleLabel.font = [UIFont fontWithName:@"Chalkboard SE" size:42.0];
    levelSelectionTitleLabel.textColor = [UIColor whiteColor];
    levelSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    levelSelectionTitleLabel.textAlignment = NSTextAlignmentCenter;
    levelSelectionTitleLabel.center = CGPointMake(self.view.center.x, 20);
    [self.view addSubview:levelSelectionTitleLabel];

    // Place a sun image at the center
    UIImage *sunImage = [UIImage imageNamed:@"Sun_Placeholder.png"];
    UIImageView *sunImageView = [[UIImageView alloc] initWithImage:sunImage];
    sunImageView.bounds = CGRectMake(0, 0, 100, 100);
    sunImageView.center = self.view.center;
    [self.view addSubview:sunImageView];
    
    // Create an orbit image for every level and place an orbiting object there (e.g., planet, asteroid, space station)
    float orbitWidthMultiplier = 0.9;
    float orbitHeightMultiplier = 0.7;
    for (int i = 0; i < numberOfLevels; i++) {
        // Orbit ellipse image
        UIImage *orbitImage = [UIImage imageNamed:@"Orbit_Placeholder.png"];
        UIImageView *orbitImageView = [[UIImageView alloc] initWithImage:orbitImage];
        orbitImageView.bounds = CGRectMake(0, 0, self.view.bounds.size.width * orbitWidthMultiplier, self.view.bounds.size.height * orbitHeightMultiplier);
        orbitImageView.center = self.view.center;
        [self.view addSubview:orbitImageView];
        
        // Level object image
        NSInteger randomImageNumber = random() % 4;
        UIImage *levelObjectImage = [UIImage imageNamed:[levelObjectImageNames objectAtIndex:randomImageNumber]];
        UIImageView *levelObjectIMageView = [[UIImageView alloc] initWithImage:levelObjectImage];
        levelObjectIMageView.bounds = CGRectMake(0, 0, self.view.bounds.size.width * 0.15, self.view.bounds.size.height * 0.15);
        levelObjectIMageView.center = CGPointMake(self.view.bounds.size.width * orbitWidthMultiplier, self.view.bounds.size.height * orbitHeightMultiplier); // TODO: Change this to a random point along the ellipse
        [self.view addSubview:levelObjectIMageView];
        
        // Prepare for next orbit
        orbitWidthMultiplier -= 0.1;
        orbitHeightMultiplier -= 0.1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //LevelInterpreter *levelInterpreter = [[LevelInterpreter alloc] init];
    //NSArray *levelData = [levelInterpreter loadLevelFileFromDisk:(NSInteger)1]; // TODO: Change this from 1 to whatever is most relevant, then pass info to levelViewController
}

@end

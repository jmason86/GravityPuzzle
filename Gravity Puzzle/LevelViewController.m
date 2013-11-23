//
//  LevelViewController.m
//  Gravity Puzzle
//
//  Created by James Paul Mason on 11/23/13.
//  Copyright (c) 2013 Trinary. All rights reserved.
//

#import "LevelViewController.h"

@interface LevelViewController ()

@end

@implementation LevelViewController

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
    
    // Place background image
    UIImage *backgroundImage = [UIImage imageNamed:@"StarFieldBackground_Placeholder.jpg"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    backgroundImageView.bounds = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
    backgroundImageView.center = CGPointMake(self.view.center.y, self.view.center.x);
    [self.view addSubview:backgroundImageView];
    
    // Define panel widths
    float leftSidePanelWidth = self.view.bounds.size.width / 4.2;
    float rightSidePanelWidth = self.view.bounds.size.width / 4.2;
    
    // Place left panel image
    UIImage *leftPanelImage = [UIImage imageNamed:@"LeftSidePanel.png"];
    UIImageView *leftPanelImageView = [[UIImageView alloc] initWithImage:leftPanelImage];
    leftPanelImageView.bounds = CGRectMake(0, 0, leftSidePanelWidth, self.view.bounds.size.width * 2);
    leftPanelImageView.center = CGPointMake(self.view.bounds.size.width / 10.0, 0);
    [self.view addSubview:leftPanelImageView];
    
    // Place right panel image
    UIImage *rightPanelImage = [UIImage imageNamed:@"RightSidePanel.png"];
    UIImageView *rightPanelImageView = [[UIImageView alloc] initWithImage:rightPanelImage];
    rightPanelImageView.bounds = CGRectMake(0, 0, rightSidePanelWidth, self.view.bounds.size.width * 2);
    rightPanelImageView.center = CGPointMake(self.view.bounds.size.height - rightSidePanelWidth / 2, 0);
    [self.view addSubview:rightPanelImageView];
	
    // Label for objects panel
    UILabel *objectPanelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    objectPanelLabel.text = @"Objects";
    objectPanelLabel.font = [UIFont fontWithName:@"Chalkboard SE" size:16.0];
    objectPanelLabel.textColor = [UIColor whiteColor];
    objectPanelLabel.backgroundColor = [UIColor clearColor];
    objectPanelLabel.textAlignment = NSTextAlignmentCenter;
    objectPanelLabel.center = CGPointMake(leftPanelImageView.center.x, 20);
    [self.view addSubview:objectPanelLabel];
    
    // Label for properties panel
    UILabel *propertyPanelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    propertyPanelLabel.text = @"Properties";
    propertyPanelLabel.font = [UIFont fontWithName:@"Chalkboard SE" size:16.0];
    propertyPanelLabel.textColor = [UIColor whiteColor];
    propertyPanelLabel.backgroundColor = [UIColor clearColor];
    propertyPanelLabel.textAlignment = NSTextAlignmentCenter;
    propertyPanelLabel.center = CGPointMake(rightPanelImageView.center.x, 20);
    [self.view addSubview:propertyPanelLabel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
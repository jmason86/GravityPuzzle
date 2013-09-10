//
//  LevelInterpreter.m
//  Gravity Puzzle
//
//  Created by James Mason on 8/18/13.
//  Copyright (c) 2013 Trinary. All rights reserved.
//

#import "LevelInterpreter.h"

@implementation LevelInterpreter

@synthesize allLevelData;

- (NSArray *)loadLevelFileFromDisk:(NSInteger)levelNumber
{
    allLevelData = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    // Search all files for the desired level
    NSArray *allFiles = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in allFiles) {
        if ([fileName isEqualToString:[NSString stringWithFormat:@"%@%i%@", @"Level", levelNumber, @".txt"]]) {
            NSString *fullFilePath = [path stringByAppendingPathComponent:fileName];
            NSString *fileContents = [NSString stringWithContentsOfFile:fullFilePath encoding:NSASCIIStringEncoding error:nil];
            
            // Read each line
            for (NSString *line in [fileContents componentsSeparatedByString:@"\n"]) {
                NSArray *allComponents = [line componentsSeparatedByString: @","];
                
                NSString *levelObjectType = [allComponents objectAtIndex:1];
                // Make NSDictionary and store each column
                NSDictionary *currentLevelObject = [[NSDictionary alloc] initWithObjects:allComponents forKeys:[self createKeysForLevelComponentsForLevelObjectType:levelObjectType]];
                [allLevelData addObject:currentLevelObject];
            }
        }
    }
    return allLevelData;
}

- (NSArray *)createKeysForLevelComponentsForLevelObjectType:(NSString *)levelObjectType
{
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"levelObjectId", @"levelObjectType", @"name", @"x", @"y", @"imageFileName", @"isVisible", @"isActive", @"initialSpeed", @"initialAngle", @"currentSpeed", @"currentAngle", @"currentAccelerationMagnitude", @"currentAccelerationAngle", @"mass", nil];
    
    switch ([levelObjectType integerValue]) {
        case 1: // Gravity well
            [keys addObject:@"isAntigravity"];
            break;
        case 2: // Black hole
            [keys addObject:@"isAntigravity"];
            [keys addObject:@"eventHorizon"];
            break;
        case 3: // Worm hole
            [keys addObject:@"entranceX"];
            [keys addObject:@"entranceY"];
            [keys addObject:@"exitX"];
            [keys addObject:@"exitY"];
            [keys addObject:@"entranceImageFilename"];
            [keys addObject:@"exitImageFilename"];
            [keys addObject:@"exitingThroughEntranceSpeed"];
            [keys addObject:@"exitingThroughEntranceSpeed"];
            [keys addObject:@"exitSpeed"];
            [keys addObject:@"exitAngle"];
            break;
        case 4: // Forcefield
            [keys addObject:@"height"];
            [keys addObject:@"width"];
            [keys addObject:@"permeability"];
            break;
        case 5: // Splitter
            [keys addObject:@"multiplier"];
            [keys addObject:@"exitAngle"];
            break;
        case 6: // Detector
            [keys addObject:@"detectionRadius"];
            [keys addObject:@"numPulses"];
            [keys addObject:@"pulseRate"];
            break;
        case 7: // Asteroid
            // Add nothing
            break;
        case 8: // Planet
            // Add nothing
            break;
        case 9: // Spaceship
            [keys addObject:@"shipAngle"];
            [keys addObject:@"numShots"];
            break;
        case 10: // Target
            // Add nothing
            break;
        case 11: // Path
            [keys addObject:@"x1"];
            [keys addObject:@"x2"];
            [keys addObject:@"y1"];
            [keys addObject:@"y2"];
            [keys addObject:@"speed"];
            [keys addObject:@"objectOnPath"];
            break;
        case 12: // Earth
            [keys addObject:@"cannonAngle"];
            [keys addObject:@"earthRadius"];
            [keys addObject:@"numShots"];
            break;
        case 13: // Cannon
            [keys addObject:@"cannonAngle"];
            [keys addObject:@"numShots"];
            break;
        default:
            break;
    }
    return keys;
}

- (NSInteger)numberOfLevels
{
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSFileManager *fileManager = [[NSFileManager alloc] init];

    // Search all files for the desired level
    NSArray *allFiles = [fileManager contentsOfDirectoryAtPath:path error:nil];
    NSInteger count = 0;
    for (NSString *fileName in allFiles) {
        if ([[fileName pathExtension] isEqualToString:@"txt"]) {
            count++;
        }
    }
    return count;
}

@end

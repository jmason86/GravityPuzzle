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

- (void)loadLevelFileFromDisk
{
    allLevelData = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    // Find all level files
    NSArray *allFiles = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in allFiles) {
        if ([[fileName pathExtension] isEqualToString:@"txt"]) {
            NSString *fullFilePath = [path stringByAppendingPathComponent:fileName];
            NSString *fileContents = [NSString stringWithContentsOfFile:fullFilePath encoding:NSASCIIStringEncoding error:nil];
            
            // Read each line
            for (NSString *line in [fileContents componentsSeparatedByString:@"\n"]) {
                NSArray *allComponents = [line componentsSeparatedByString: @","];
                
                NSString *levelObjectType = [allComponents objectAtIndex:1];
                // Make NSDictionary and store each column
                NSDictionary *rowComponents = [[NSDictionary alloc] initWithObjects:allComponents forKeys:[self createKeysForLevelComponentsForLevelObjectType:levelObjectType]];
                [allLevelData addObject:rowComponents];
            }
        }
    }
}

- (NSArray *)createKeysForLevelComponentsForLevelObjectType:(NSString *)levelObjectType
{
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"levelObjectId", @"levelObjectType", @"name", @"x", @"y", @"imageFileName", @"isVisible", @"isActive", @"initialSpeed", @"initialAngle", @"currentSpeed", @"currentAngle", @"currentAccelerationMagnitude", @"currentAccelerationAngle", @"mass", nil];
    
    switch ([levelObjectType integerValue]) {
        case 1: // Gravity well
            [keys addObject:@"antigravity"];
            break;
        case 2: // Black hole
            [keys addObject:@"antigravity"];
            [keys addObject:@"bla"];
            break;
        case 3: // Worm hole
            [keys addObject:@"bla1"];
            [keys addObject:@"bla2"];
            [keys addObject:@"bla3"];
            [keys addObject:@"bla4"];
            [keys addObject:@"bla5"];
            [keys addObject:@"bla6"];
            [keys addObject:@"bla7"];
            [keys addObject:@"bla8"];
            [keys addObject:@"bla9"];
            [keys addObject:@"bla10"];
            break;
        case 4: // Forcefield
            [keys addObject:@"bla1"];
            [keys addObject:@"bla2"];
            [keys addObject:@"bla3"];
            break;
        case 5: // Splitter
            [keys addObject:@"bla1"];
            [keys addObject:@"bla2"];
            break;
        case 6: // Detector
            [keys addObject:@"bla1"];
            [keys addObject:@"bla2"];
            [keys addObject:@"bla3"];
            break;
        case 7: // Asteroid
            // Add nothing
            break;
        case 8: // Planet
            // Add nothing
            break;
        case 9: // Spaceship
            [keys addObject:@"bla1"];
            [keys addObject:@"bla2"];
            break;
        case 10: // Target
            // Add nothing
            break;
        case 11: // Path
            [keys addObject:@"bla1"];
            [keys addObject:@"bla2"];
            [keys addObject:@"bla3"];
            [keys addObject:@"bla4"];
            [keys addObject:@"bla5"];
            [keys addObject:@"bla6"];
            break;
        case 12: // Earth
            [keys addObject:@"bla1"];
            [keys addObject:@"bla2"];
            [keys addObject:@"bla3"];
            break;
        case 13: // Cannon
            [keys addObject:@"bla1"];
            [keys addObject:@"bla2"];
            break;
        default:
            break;
    }
    return keys;
}

@end

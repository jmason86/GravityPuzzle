//
//  LevelInterpreter.h
//  Gravity Puzzle
//
//  Created by James Mason on 8/18/13.
//  Copyright (c) 2013 Trinary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelInterpreter : NSObject

- (NSArray *)loadLevelFileFromDisk:(NSInteger)levelNumber;

- (NSInteger)numberOfLevels;

@property NSMutableArray *allLevelData;

@end

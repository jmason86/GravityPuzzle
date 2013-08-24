//
//  LevelInterpreter.h
//  Gravity Puzzle
//
//  Created by James Mason on 8/18/13.
//  Copyright (c) 2013 Trinary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelInterpreter : NSObject

- (void)loadLevelFileFromDisk;

@property NSMutableArray *allLevelData;

@end

//
//  DTIComputerPlayerRule.h
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DTIGameBoard;

@interface DTIComputerPlayerRule : NSObject
{
    DTIGameBoard* _board;
    NSArray* _squares;
}

+(NSArray*)buildAllWithGameBoard:(DTIGameBoard*)board andSquares:(NSArray*)squares;

-(id)initWithGameBoard:(DTIGameBoard*)board andSquares:(NSArray*)squares;
-(bool)tryPlay;


-(NSNumber*)tryFindEmptySpaceInSquares:(NSInteger)one
                                      :(NSInteger)two
                                      :(NSInteger)three;

@end

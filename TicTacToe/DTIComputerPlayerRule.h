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

-(id)initWithGameBoard:(DTIGameBoard*)board andSquares:(NSArray*)squares;
-(bool)tryPlay;

@end

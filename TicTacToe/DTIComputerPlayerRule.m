//
//  DTIComputerPlayerRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIComputerPlayerRule.h"

@implementation DTIComputerPlayerRule

-(id)initWithGameBoard:(DTIGameBoard*)board andSquares:(NSArray*)squares
{
    if( self = [super init] )
    {
        _board = board;
        _squares = squares;
    }
    return self;
}

-(NSNumber*)tryPlay
{
    // To implement in subtypes
    return nil;
}

@end

//
//  DTIEmptyCornerRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIEmptySquareRule.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

static const NSInteger kCorners[4] = {0, 2, 6, 8};
static const NSInteger kSides[4] = {1, 3, 5, 7};

@implementation DTIEmptySquareRule

-(bool)tryPlay
{
    // Play corners in order, then sides
    return (   [self tryPlayFromArray:kCorners]
            || [self tryPlayFromArray:kSides]);
}

-(bool)tryPlayFromArray:(const NSInteger[])squares
{
    for( int i = 0; i < 4; ++i )
    {
        if( _squares[squares[i]] == [DTIPlayer unplayed] )
        {
            [_board play:_board.player inSquare:squares[i]];
            return true;
        }
    }
    return false;
}


@end

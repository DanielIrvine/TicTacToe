//
//  DTIWinRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//
//  The win rule occurs when the player can make a winning move.

#import "DTIWinRule.h"
#import "DTIGameBoard.h"

@implementation DTIWinRule

-(bool)tryPlay
{
    for( NSArray* winningTriplet in _board.winningTriplets )
    {
        NSNumber* move = [self tryFindEmptySpaceInSquares:[winningTriplet[0] integerValue]
                                                         :[winningTriplet[1] integerValue]
                                                         :[winningTriplet[2] integerValue]];

        if( move != nil )
        {
            NSNumber* player = move == winningTriplet[0] ? winningTriplet[1] : winningTriplet[0];

            if( player == _board.player )
            {
                [_board play:[_board.player charValue]
                    inSquare:[move integerValue]];
                return true;
            }
        }
    }

    return false;
}


@end

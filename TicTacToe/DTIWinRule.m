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
            DTIPlayer* player = move == winningTriplet[0]
            ? _squares[[winningTriplet[1] integerValue]]
            : _squares[[winningTriplet[0] integerValue]];

            if( player == _board.player )
            {
                [_board play:_board.player
                    inSquare:[move integerValue]];
                return true;
            }
        }
    }

    return false;
}


@end

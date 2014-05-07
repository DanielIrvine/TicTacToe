//
//  DTIBlockRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//
//  The block rule is enforced when the human player has made a line of two
//  and the third square is not yet blocked.

#import "DTIBlockRule.h"
#import "DTIGameBoard.h"

@implementation DTIBlockRule

-(bool)tryPlay
{
    // TODO: pretty much the same code as DTIWinRule except for the innermost
    // conditional, so this could be pulled out
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

            if( player != _board.player )
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

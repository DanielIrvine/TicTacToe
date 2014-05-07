//
//  DTIForkRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//
//  A fork is a play that will create two non-blocked lines of two. To do this,
//  look for unblocked lines with just one play from this player so far, and
//  use a count to determine if a play can be made.

#import "DTIForkRule.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

@implementation DTIForkRule

-(bool)tryPlay
{
    NSInteger counts[9] = {0};
    for( NSArray* winningTriplet in _board.winningTriplets )
    {
        NSNumber* blockedSquare =
        [self determineIfOnlyOneSquareBlockedInTriplet:winningTriplet];

        if( blockedSquare != nil
           && _squares[blockedSquare.integerValue] == _board.player)
        {
            for( NSNumber* square in winningTriplet )
            {
                if( ![square isEqualToValue:blockedSquare] )
                {
                    // This square is not blocked, so increment its count
                    NSInteger index = [square integerValue];
                    counts[index]++;

                    if( counts[index] == 2 )
                    {
                        [_board play:_board.player
                            inSquare:[square integerValue]];
                        return true;
                    }
                }
            }
        }
    }

    return false;
}

@end

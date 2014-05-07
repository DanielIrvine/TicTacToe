//
//  DTIBlockForkRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//
//  A fork is blocked by forming a line of two away from a square that an
//  opponent would use to fork. So find all these "fork points" and then find
//  a winnable row not including those fork points, and place a second point
//  in that.

#import "DTIBlockForkRule.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

@implementation DTIBlockForkRule

-(bool)tryPlay
{
    // FIXME: really long method, need to refactor some of this out
    NSInteger counts[9] = {0};
    bool mustBlock = false;
    for( NSArray* winningTriplet in _board.winningTriplets )
    {
        NSNumber* blockedSquare = [self determineIfOnlyOneSquareBlockedInTriplet:winningTriplet];

        if( blockedSquare != nil
           && _squares[blockedSquare.integerValue] == [_board.player opponent])
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
                        mustBlock = true;
                    }
                }
            }
        }
    }

    if( mustBlock )
    {
        NSNumber* candidate;
        for( NSArray* winningTriplet in _board.winningTriplets )
        {
            NSNumber* blockedSquare = [self determineIfOnlyOneSquareBlockedInTriplet:winningTriplet];

            if( blockedSquare != nil
               && _squares[blockedSquare.integerValue] == _board.player )
            {
                NSMutableArray* freeSquares = [winningTriplet mutableCopy];
                [freeSquares removeObjectIdenticalTo:blockedSquare];

                if(counts[[freeSquares[0] integerValue]] == 2
                   && counts[[freeSquares[1] integerValue]] == 2)
                {
                    // Can't play here as the player could still then fork
                    break;
                }

                if( [self playSquareIfHasCountOfTwo:freeSquares[0] :counts]
                   || [self playSquareIfHasCountOfTwo:freeSquares[1] :counts])
                    return true;

                // Either square is an acceptable position to move,
                // but don't move yet--wait to see if any counts of 2 are
                // discovered as they should have priority. Instead just save off
                // the candidate.
                candidate = freeSquares[0];
            }
        }

        if( candidate != nil ) // This should always be true
        {
            [_board play:_board.player inSquare:[candidate integerValue]];
            return true;
        }
    }

    return false;
}

-(bool)playSquareIfHasCountOfTwo:(NSNumber*)square :(NSInteger[])counts
{
    if( counts[square.integerValue] == 2 )
    {
        [_board play:_board.player inSquare:square.integerValue];
        return true;
    }
    return false;
}

@end

//
//  DTIWinRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//
//  The win rule occurs when the player can make a winning move.

#import "DTIRowOfTwoRule.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

@implementation DTIRowOfTwoRule

-(id)initWithPlayerToCheck:(DTIPlayer*)playerToCheck
              andGameBoard:(DTIGameBoard*)board
                andSquares:(NSArray*)squares
{
    if(self = [super initWithGameBoard:board andSquares:squares])
    {
        _playerToCheck = playerToCheck;
    }
    return self;
}

+(DTIRowOfTwoRule*)winRuleForBoard:(DTIGameBoard*)board
                        andSquares:(NSArray*)squares
{
    return [[DTIRowOfTwoRule alloc] initWithPlayerToCheck:board.player
                                             andGameBoard:board
                                               andSquares:squares];
}

+(DTIRowOfTwoRule*)blockRuleForBoard:(DTIGameBoard*)board
                          andSquares:(NSArray*)squares
{
    return [[DTIRowOfTwoRule alloc] initWithPlayerToCheck:[board.player opponent]
                                             andGameBoard:board
                                               andSquares:squares];
}

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

            if( player == _playerToCheck )
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

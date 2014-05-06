//
//  DTIWinRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIWinRule.h"
#import "DTIGameBoard.h"

@implementation DTIWinRule

-(bool)tryPlay
{
    for( NSArray* winningTriplet in _board.winningTriplets )
    {
        NSNumber* move = [self tryFindEmptySpaceinSquares:[winningTriplet[0] integerValue]
                                                         :[winningTriplet[1] integerValue]
                                                         :[winningTriplet[2] integerValue]];

        if( move != nil )
        {
            NSNumber* player = move == winningTriplet[0] ? winningTriplet[1] : winningTriplet[0];

            if( player == _board.player )
            {
                [_board play:[_board.player charValue]
                    inSquare:[move integerValue]];
                break;
            }
        }
    }

    return true;
}


-(NSNumber*)tryFindEmptySpaceinSquares:(NSInteger)one
                                      :(NSInteger)two
                                      :(NSInteger)three
{
    if(_squares[three] == nil
       && [self twoSquaresAreEqual:one :two] )
        return @(three);
    else if(_squares[one] == nil
            && [self twoSquaresAreEqual:two:three] )
        return @(one);
    else if(_squares[two] == nil
            && [self twoSquaresAreEqual:one:three] )
        return @(two);

    return nil;
}

-(bool)twoSquaresAreEqual:(NSInteger)one
                         :(NSInteger)two
{
    return _squares[one] != nil && [_squares[one] isEqualToValue:_squares[two]];
}

@end

//
//  DTIComputerPlayerRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIComputerPlayerRule.h"
#import "DTIWinRule.h"
#import "DTIBlockRule.h"
#import "DTIForkRule.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

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

// Each of these rules must be applied in this order to ensure a win or draw
+(NSArray*)buildAllWithGameBoard:(DTIGameBoard*)board andSquares:(NSArray*)squares
{
    return @[[[DTIWinRule alloc] initWithGameBoard:board andSquares:squares],
             [[DTIBlockRule alloc] initWithGameBoard:board andSquares:squares],
             [[DTIForkRule alloc] initWithGameBoard:board andSquares:squares]];
}

-(bool)tryPlay
{
    // To implement in subtypes
    return nil;
}

-(NSNumber*)tryFindEmptySpaceInSquares:(NSInteger)one
                                      :(NSInteger)two
                                      :(NSInteger)three
{
    if(_squares[three] == [DTIPlayer unplayed]
       && [self twoSquaresAreEqual:one :two] )
        return @(three);
    else if(_squares[one] == [DTIPlayer unplayed]
            && [self twoSquaresAreEqual:two:three] )
        return @(one);
    else if(_squares[two] == [DTIPlayer unplayed]
            && [self twoSquaresAreEqual:one:three] )
        return @(two);

    return nil;
}

-(bool)twoSquaresAreEqual:(NSInteger)one
                         :(NSInteger)two
{
    return _squares[one] != [DTIPlayer unplayed]
    && _squares[one] == _squares[two];
}

@end

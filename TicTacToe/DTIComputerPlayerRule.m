//
//  DTIComputerPlayerRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIComputerPlayerRule.h"
#import "DTIBlockForkRule.h"
#import "DTIRowOfTwoRule.h"
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
    return @[[DTIRowOfTwoRule winRuleForBoard:board andSquares:squares],
             [DTIRowOfTwoRule blockRuleForBoard:board andSquares:squares],
             [[DTIForkRule alloc] initWithGameBoard:board andSquares:squares],
             [[DTIBlockForkRule alloc] initWithGameBoard:board andSquares:squares]];
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


// FIXME: may be better to put these on a separate subtype
-(NSNumber*)determineIfOnlyOneSquareBlockedInTriplet:(NSArray*)triplet
{
    if( [self isBlocked:triplet[0] andNotBlocked:triplet[1] :triplet[2]])
        return triplet[0];
    if( [self isBlocked:triplet[1] andNotBlocked:triplet[0] :triplet[2]])
        return triplet[1];
    if( [self isBlocked:triplet[2] andNotBlocked:triplet[0] :triplet[1]])
        return triplet[2];

    return nil;
}

-(bool)isBlocked:(NSNumber*)one andNotBlocked:(NSNumber*)two :(NSNumber*)three
{
    return _squares[one.integerValue] != [DTIPlayer unplayed]
    && _squares[two.integerValue] == [DTIPlayer unplayed]
    && _squares[three.integerValue] == [DTIPlayer unplayed];
}

@end

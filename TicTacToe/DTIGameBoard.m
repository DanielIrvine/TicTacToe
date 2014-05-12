//
//  DTIGameBoard.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIGameBoard.h"
#import "DTIPlayer.h"

static NSArray* kWinningTriplets;

@implementation DTIGameBoard

+(void)initialize
{
    kWinningTriplets = @[@[@0,@1,@2],
                         @[@3,@4,@5],
                         @[@6,@7,@8],
                         @[@0,@3,@6],
                         @[@1,@4,@7],
                         @[@2,@5,@8],
                         @[@0,@4,@8],
                         @[@2,@4,@6]];
}

-(NSArray*) winningTriplets
{
    return kWinningTriplets;
}

-(id)init
{
    if(self = [super init])
    {
        _squares = [[NSMutableArray alloc] initWithCapacity:9];
        for (NSInteger i = 0; i < 9; i++) {
            [_squares insertObject:[NSNull null] atIndex:i];
        }
    }
    return self;
}

-(id)initWithExistingBoard:(DTIGameBoard*)board
                andNewMove:(NSNumber*)move
                  asPlayer:(DTIPlayer*)player
{
    if(self = [super init])
    {
        _squares = [board.squares mutableCopy];
        _squares[move.integerValue] = player;
    }

    return self;
}

-(DTIGameBoard*)playSquare:(NSNumber*)move asPlayer:(DTIPlayer*)player
{
    return [[DTIGameBoard alloc] initWithExistingBoard:self
                                            andNewMove:move asPlayer:player];
}


-(bool)isWon
{
    return [self getWinningTriplet] != nil;
}

-(NSArray*)getWinningTriplet
{
    for( NSArray* winningTriplet in kWinningTriplets )
    {
        if( [self threeSquaresAreEqual:[winningTriplet[0] integerValue]
                                      :[winningTriplet[1] integerValue]
                                      :[winningTriplet[2] integerValue]])
        {
            return winningTriplet;
        }
    }
    return nil;
}

-(bool)isDrawn
{
    return [self noSquaresEmpty] && ![self isWon];
}

-(bool)noSquaresEmpty
{
    for(int i = 0; i < 9; ++i)
        if(_squares[i] == [NSNull null])
            return false;

    return true;
}

-(bool)threeSquaresAreEqual:(NSInteger)one
                           :(NSInteger)two
                           :(NSInteger)three
{
    return _squares[one] != [NSNull null]
    && _squares[one] == _squares[two]
    && _squares[one] == _squares[three];
}

-(NSArray*)availableSpaces
{
    NSMutableArray* availableSpaces = [[NSMutableArray alloc] init];
    for(int i = 0; i < 9; ++i)
    {
        if(_squares[i] == [NSNull null])
            [availableSpaces addObject:[NSNumber numberWithInteger:i]];
    }

    return availableSpaces;
}

-(NSString*)description
{
    NSMutableString* str = [[NSMutableString alloc] init];
    for( id player in _squares)
    {
        if(player == [NSNull null])
            [str appendString:@"-"];
        else
            [str appendString:[player description]];
    }
    return str;
}

-(NSString*)debugDescription
{
    return [self description];
}

-(DTIGameBoard*)rotateBy:(NSArray*)rotation
{
    DTIGameBoard* rotated = [[DTIGameBoard alloc] init];
    for( int i = 0; i < 9; ++i )
    {
        rotated = [rotated playSquare:rotation[i] asPlayer:_squares[i]];
    }
    return rotated;
}

@end

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

-(id)initWithComputerPlayerAs:(DTIPlayer*)player
{
    if(self = [super init])
    {
        _squares = [[NSMutableArray alloc] initWithCapacity:9];
        for (NSInteger i = 0; i < 9; i++) {
            [_squares insertObject:[NSNull null] atIndex:i];
        }
        _computer = player;
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

        _computer = board.computer;
    }

    return self;
}

-(bool)isWon
{
    for( NSArray* winningTriplet in kWinningTriplets )
    {
        if( [self threeSquaresAreEqual:[winningTriplet[0] integerValue]
                                      :[winningTriplet[1] integerValue]
                                      :[winningTriplet[2] integerValue]])
        {
            return true;
        }
    }
    return false;
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

-(void)play:(DTIPlayer*)player inSquare:(NSInteger)square
{
    _lastPlayedSquare = @(square);
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
    for( DTIPlayer* player in _squares)
    {
        [str appendString:player.description];
    }
    return str;
}
@end

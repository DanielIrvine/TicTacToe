//
//  DTIGameBoard.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIGameBoard.h"
#import "DTIComputerPlayerRule.h"
#import "DTIWinRule.h"
#import "DTIBlockRule.h"
#import "DTIPlayer.h"

@implementation DTIGameBoard

-(id)initWithComputerPlayerAs:(DTIPlayer*)player
{
    if(self = [super init])
    {
        _squares = [[NSMutableArray alloc] initWithCapacity:9];
        for (NSInteger i = 0; i < 9; i++) {
            [_squares insertObject:[DTIPlayer unplayed] atIndex:i];
        }
        _player = player;

        _winningTriplets = @[@[@0,@1,@2],
                             @[@3,@4,@5],
                             @[@6,@7,@8],
                             @[@0,@3,@6],
                             @[@1,@4,@7],
                             @[@2,@5,@8],
                             @[@0,@4,@8],
                             @[@2,@4,@6]];

        _computerPlayerRules = [DTIComputerPlayerRule buildAllWithGameBoard:self
                                                                 andSquares:_squares];
    }
    return self;
}

-(bool)isWon
{
    for( NSArray* winningTriplet in _winningTriplets )
    {
        if( [self threeSquaresAreEqual:[winningTriplet[0] integerValue]
                                      :[winningTriplet[1] integerValue]
                                      :[winningTriplet[2] integerValue]])
        {
            if( _squares[[winningTriplet[0] integerValue]] == _player )
            {
                return true;
            }
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
        if(_squares[i] == [DTIPlayer unplayed])
            return false;

    return true;
}

-(bool)threeSquaresAreEqual:(NSInteger)one
                           :(NSInteger)two
                           :(NSInteger)three
{
    return _squares[one] != [DTIPlayer unplayed]
    && _squares[one] == _squares[two]
    && _squares[one] == _squares[three];
}

-(void)play:(DTIPlayer*)player inSquare:(NSInteger)square
{
    _squares[square] = player;
    _lastBlockedSquare = @(square);
}

-(void)playBestMove
{
    for( DTIComputerPlayerRule* rule in _computerPlayerRules)
    {
        if( [rule tryPlay] )
            break;
    }

}

@end

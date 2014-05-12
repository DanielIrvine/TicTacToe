//
//  DTIGame.m
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIGame.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

@implementation DTIGame

-(id)init
{
    return [self initWithGameBoard:nil];
}

-(id)initWithGameBoard:(DTIGameBoard*)board
{
    if(self = [super init])
    {
        [self reset];
        _lastPlayedSquares = [[NSMutableArray alloc] init];
        _board = board;

        _x = [DTIPlayer createOpposingPlayers];
    }
    return self;
}

-(void)reset
{
    _isLost = false;
    _isDrawn = false;
    [_lastPlayedSquares removeAllObjects];
}

-(void)resetWithComputerFirst
{
    [self reset];

    _board = [[DTIGameBoard alloc] initWithComputerPlayerAs:_x];
    [self playComputer];
}

-(void)resetWithPlayerFirst
{
    [self reset];
    _board = [[DTIGameBoard alloc] initWithComputerPlayerAs:_x.opponent];
}

-(void)play:(NSInteger)square
{
    if( [self isInPlay] )
    {
        _board = [[DTIGameBoard alloc] initWithExistingBoard:_board
                                                  andNewMove:@(square)
                                                    asPlayer:[_board.computer opponent]];
        [self update];
    }
}

-(void)playComputer
{
    if( [self isInPlay] )
    {
        _board = [_board.computer getBestPlayFor:_board];
        [self update];
    }
}

-(void)update
{
    [_lastPlayedSquares addObject:_board.lastPlayedSquare];

    if( [_board isWon] ) { // This is always a win for the computer
        _lost++;
        _isLost = true;
    }
    else if( [_board isDrawn])
    {
        _drawn++;
        _isDrawn = true;
    }
}

-(void)touchIn:(NSInteger)square
{
    if( ![self isInPlay] )
    {
        [self reset];
    }
    else
    {
        [_lastPlayedSquares removeAllObjects];
        [self play:square];
        [self playComputer];
    }
}

-(void)touchOutsideSquare
{
    if( ![self isInPlay] )
    {
        [self reset];
    }
}

-(bool)isInPlay
{
    return !_isDrawn && !_isLost;
}

-(NSArray*)getPlaysInOrder
{
    return _lastPlayedSquares;
}

@end

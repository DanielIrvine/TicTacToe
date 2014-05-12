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

-(void)play:(NSNumber*)square
{
    if( [self isInPlay] )
    {
        [self makePlayInSquare:square
                     forPlayer:[_board.computer opponent]];
    }
}

-(void)playComputer
{
    if( [self isInPlay] )
    {
        [self makePlayInSquare:[_board.computer makeBestPlayFor:_board]
                     forPlayer:_board.computer];
    }
}

-(void)makePlayInSquare:(NSNumber*)square forPlayer:(DTIPlayer*)player
{
    _board = [[DTIGameBoard alloc] initWithExistingBoard:_board
                                              andNewMove:square
                                                asPlayer:player];
    [_lastPlayedSquares addObject:square];
    [self update];
}

-(void)update
{

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
        [self play:@(square)];
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

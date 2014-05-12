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
    if(self = [super init])
    {
        [self reset];
        _lastPlayedSquares = [[NSMutableArray alloc] init];
        _x = [DTIPlayer createOpposingPlayers];
        [self setComputerAndOpponentWith:_x];
        _board = [[DTIGameBoard alloc] init];
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

    _board = [[DTIGameBoard alloc] init];
    [self setComputerAndOpponentWith:_x];
    [self playComputer];
}

-(void)resetWithPlayerFirst
{
    [self reset];
    _board = [[DTIGameBoard alloc] init];
    [self setComputerAndOpponentWith:[_x opponent]];
}

-(void)setComputerAndOpponentWith:(DTIPlayer*)computer
{
    _computer = computer;
    _human = [computer opponent];
}
-(void)play:(NSNumber*)square
{
    if( [self isInPlay] )
    {
        [self makePlayInSquare:square
                     forPlayer:_human];
    }
}

-(void)playComputer
{
    if( [self isInPlay] )
    {
        [self makePlayInSquare:[_computer makeBestPlayFor:_board]
                     forPlayer:_computer];
    }
}

-(void)makePlayInSquare:(NSNumber*)square forPlayer:(DTIPlayer*)player
{
    _board = [_board playSquare:square asPlayer:player];
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

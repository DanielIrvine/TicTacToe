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
    }
    return self;
}

-(void)reset
{
    _isLost = false;
    _isDrawn = false;
    _lastPlayer = [DTIPlayer o];
}

-(void)resetWithComputerFirst
{
    [self reset];
    _board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer x]];
    [self playComputer];
}

-(void)resetWithPlayerFirst
{
    [self reset];
    _board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer o]];
}

-(void)play:(NSInteger)square
{
    [_board play:[_board.player opponent] inSquare:square];
    [self update];
}

-(void)playComputer
{
    [_board playBestMove];
    [self update];
}

-(void)update
{
    _lastPlayer = [_lastPlayer opponent];
    _lastPlayedSquare = _board.lastPlayedSquare;

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

@end

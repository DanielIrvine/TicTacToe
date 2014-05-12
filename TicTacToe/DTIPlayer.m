//
//  DTISquareState.m
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIPlayer.h"
#import "DTIGameBoard.h"
#import "DTIPossibleMove.h"
#import "DTIPossibleMoveStore.h"

@implementation DTIPlayer

-(id)initWithPlayer:(NSString*)player andStore:(DTIPossibleMoveStore*)store
{
    if(self = [super init])
    {
        _player = player;
        _store = store;
    }
    return self;

}

+(DTIPlayer*)createOpposingPlayers
{
    DTIPossibleMoveStore* store = [[DTIPossibleMoveStore alloc] init];
    DTIPlayer* x = [[DTIPlayer alloc] initWithPlayer:@"X" andStore:store];
    DTIPlayer* o = [[DTIPlayer alloc] initWithPlayer:@"O" andStore:store];
    x.opponent = o;
    o.opponent = x;
    return x;
}

-(NSNumber*)makeBestPlayFor:(DTIGameBoard*)gameBoard
{
    DTIPossibleMove* move = [self getBestPossibleMoveFor:gameBoard];
    return move.square;
}

-(DTIPossibleMove*)getBestPossibleMoveFor:(DTIGameBoard*)gameBoard
{
    DTIPossibleMove* bestMove = [_store getAlreadyCalculatedValueFor:gameBoard];
    if(bestMove != nil)
    {
        return bestMove;
    }

    for( NSNumber* move in [gameBoard availableSpaces] )
    {
        DTIGameBoard* nextBoard = [[DTIGameBoard alloc] initWithExistingBoard:gameBoard
                                                                   andNewMove:move
                                                                     asPlayer:self];

        if( [nextBoard isDrawn] )
        {
            bestMove = [DTIPossibleMove buildWithScore:0 andSquare:move];
        }
        else if( [nextBoard isWon] )
        {
            bestMove = [DTIPossibleMove buildWithScore:1 andSquare:move];
        }
        else
        {
            DTIPossibleMove* theirMove = [self.opponent getBestPossibleMoveFor:nextBoard];
            int reversedScore = -theirMove.score;
            if( bestMove == nil || bestMove.score < reversedScore )
            {
                bestMove = [DTIPossibleMove buildWithScore:reversedScore
                                                 andSquare:move];
            }
        }
    }

    [_store insertCalculatedMoveFor:gameBoard of:bestMove];

    return bestMove;
}

-(NSString *)description
{
    return _player;
}

-(NSString *)debugDescription
{
    return _player;
}


@end


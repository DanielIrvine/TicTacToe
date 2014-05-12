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

@implementation DTIPlayer

-(id)initWithPlayer:(NSString*)player
{
    if(self = [super init])
    {
        _player = player;
    }
    return self;

}

+(DTIPlayer*)createOpposingPlayers
{
    DTIPlayer* x = [[DTIPlayer alloc] initWithPlayer:@"X"];
    DTIPlayer* o = [[DTIPlayer alloc] initWithPlayer:@"O"];
    x.opponent = o;
    o.opponent = x;
    return x;
}

-(DTIGameBoard*)makeBestPlayFor:(DTIGameBoard*)gameBoard
{
    DTIPossibleMove* move = [self getBestPossibleMoveFor:gameBoard];
    return [[DTIGameBoard alloc] initWithExistingBoard:gameBoard
                                            andNewMove:move.square
                                              asPlayer:self];
}

-(DTIPossibleMove*)getBestPossibleMoveFor:(DTIGameBoard*)gameBoard
{
    DTIPossibleMove* bestMove;
    for( NSNumber* move in [gameBoard availableSpaces] )
    {
        DTIGameBoard* nextBoard = [[DTIGameBoard alloc] initWithExistingBoard:gameBoard
                                                                   andNewMove:move
                                                                     asPlayer:self];

        if( [nextBoard isDrawn] )
        {
            bestMove = [DTIPossibleMove moveWithScore:0 andSquare:move];
        }
        if( [nextBoard isWon] )
        {
            bestMove = [DTIPossibleMove moveWithScore:1 andSquare:move];
        }
        else
        {
            DTIPossibleMove* theirMove = [self.opponent getBestPossibleMoveFor:nextBoard];
            theirMove.score = -theirMove.score;
            if( bestMove == nil || bestMove.score < theirMove.score )
            {
                bestMove = [DTIPossibleMove moveWithScore:theirMove.score
                                                andSquare:move];
            }
        }
    }

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


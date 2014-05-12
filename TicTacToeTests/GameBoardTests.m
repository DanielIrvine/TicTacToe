//
//  TicTacToeTests.m
//  TicTacToeTests
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameBoardTests.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

@implementation GameBoardTests

-(void)setUp
{
    [super setUp];
}


-(void)testAllPossibleGameBoardsResultInWin
{
    DTIGameBoard* computerFirst = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer x]];
    DTIGameBoard* humanFirst = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer o]];

    DTIPlayer* firstPlayer = [DTIPlayer x];
    XCTAssertTrue([self playNextMove:computerFirst forPlayer:firstPlayer]);
    XCTAssertTrue([self playNextMove:humanFirst forPlayer:firstPlayer]);

}

-(bool)playNextMove:(DTIGameBoard*)board
          forPlayer:(DTIPlayer*)player
{
    if( [board isDrawn] )
    {
        return true;
    }
    else if( [board isWon] )
    {
        if( board.computer == player) // means that the player won!
        {
            return false;
        }
        return true;
    }

    DTIPlayer* nextPlayer = [player opponent];
    if( board.computer == player )
    {
        DTIGameBoard* nextBoard = [board playBestMove];

        return [self playNextMove:nextBoard forPlayer:nextPlayer];
    }
    else
    {
        bool allTrue = true;
        for( NSNumber* availableMove in [board availableSpaces] )
        {
            DTIGameBoard* nextBoard = [[DTIGameBoard alloc] initWithExistingBoard:board
                                                                       andNewMove:availableMove
                                                                         asPlayer:player];

            allTrue &= [self playNextMove:nextBoard forPlayer:nextPlayer];
        }

        return allTrue;
    }
}


+(void)playSequence:(NSString*)sequence on:(DTIGameBoard*)board
{
    for( int i = 0; i < 9; ++i )
    {
        unichar c = [sequence characterAtIndex:i];
        if( c != '-' )
        {
            [board play:[self getPlayerForCharacter:c] inSquare:i];
        }
    }
}

-(NSMutableArray*)splitSequenceIntoArray:(NSString*)sequence
{
    NSMutableArray* sequenceArray = [[NSMutableArray alloc] init];
    for( int i = 0; i < 9; ++i )
    {
        [sequenceArray addObject:[GameBoardTests getPlayerForCharacter:[sequence characterAtIndex:i]]];
    }
    return sequenceArray;
}

+(DTIPlayer*)getPlayerForCharacter:(unichar)character
{
    switch(character)
    {
        case 'X':
            return [DTIPlayer x];
        case 'O':
            return [DTIPlayer o];
        default:
            return [DTIPlayer unplayed];
    }
}

@end

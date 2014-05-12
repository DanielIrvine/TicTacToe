//
//  TicTacToeTests.m
//  TicTacToeTests
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

@interface GameBoardTests : XCTestCase

@end

@implementation GameBoardTests

-(void)setUp
{
    [super setUp];
}


-(void)testAllPossibleGameBoardsResultInWin
{
    DTIPlayer* x = [DTIPlayer createOpposingPlayers];

    DTIGameBoard* computerFirst = [[DTIGameBoard alloc] init];
    DTIGameBoard* humanFirst = [[DTIGameBoard alloc] init];

    XCTAssertTrue([self playNextMove:computerFirst
                           forPlayer:x
                        withComputer:x]);
    XCTAssertTrue([self playNextMove:humanFirst
                           forPlayer:x
                        withComputer:x.opponent]);

}

-(bool)playNextMove:(DTIGameBoard*)board
          forPlayer:(DTIPlayer*)player
                        withComputer:(DTIPlayer*)computer
{
    if( [board isDrawn] )
    {
        return true;
    }
    else if( [board isWon] )
    {
        if( computer == player) // means that the player won!
        {
            NSLog(@"Error: %@", board);
            return false;
        }
        return true;
    }

    DTIPlayer* nextPlayer = [player opponent];
    if( computer == player )
    {
        NSNumber* play = [computer makeBestPlayFor:board];
        DTIGameBoard* nextBoard = [[DTIGameBoard alloc] initWithExistingBoard:board
                                                                   andNewMove:play
                                                                     asPlayer:player];

        return [self playNextMove:nextBoard forPlayer:nextPlayer withComputer:computer];
    }
    else
    {
        bool allTrue = true;
        for( NSNumber* availableMove in [board availableSpaces] )
        {
            DTIGameBoard* nextBoard = [[DTIGameBoard alloc] initWithExistingBoard:board
                                                                       andNewMove:availableMove
                                                                         asPlayer:player];

            allTrue &= [self playNextMove:nextBoard
                                forPlayer:nextPlayer
                             withComputer:computer];
        }

        return allTrue;
    }
}

@end

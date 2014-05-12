//
//  GameTests.m
//  TicTacToe
//
//  Created by Daniel Irvine on 08/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DTIGame.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

@interface GameTests : XCTestCase
@end

@implementation GameTests

-(void)testWhenTouchingOutsideWhenFinishedThenGameIsReset
{
    DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer createOpposingPlayers]];
    [GameTests playSequence:@"XX-O-----" on:board];

    DTIGame* game = [[DTIGame alloc] initWithGameBoard:board];
    [game touchIn:4];  // to finish game
    [game touchOutsideSquare];

    XCTAssertFalse([game isLost]);
    XCTAssertTrue([game isInPlay]);
}

-(void)testWhenTouchingInSquareWhenFinishedThenGameIsReset
{
    DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer createOpposingPlayers]];
    [GameTests playSequence:@"XX-O-----" on:board];

    DTIGame* game = [[DTIGame alloc] initWithGameBoard:board];
    [game touchIn:4];  // to finish game
    [game touchIn:5];

    XCTAssertFalse([game isLost]);
    XCTAssertTrue([game isInPlay]);
}

-(void)testWhenTouchingInSquareDuringGameThenSquareIsPlayed
{
    DTIGame* game = [[DTIGame alloc] init];
    [game resetWithPlayerFirst];
    [game touchIn:4];
    XCTAssertEqual(2, [game getPlaysInOrder].count);
    XCTAssertEqual(4, [[game getPlaysInOrder][0] integerValue]);
}

-(void)testWhenGameLostThenIsLostValuesAreSet
{
    DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer createOpposingPlayers]];
    [GameTests playSequence:@"XX-O-----" on:board];

    DTIGame* game = [[DTIGame alloc] initWithGameBoard:board];
    [game touchIn:4];

    XCTAssertTrue([game isLost]);
    XCTAssertFalse([game isInPlay]);
    XCTAssertEqual(1, game.lost);
}

-(void)testWhenGameDrawThenIsDrawnValuesAreSet
{
    DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer createOpposingPlayers]];
    [GameTests playSequence:@"XXOOOXXX-" on:board];

    DTIGame* game = [[DTIGame alloc] initWithGameBoard:board];
    [game touchIn:8];

    XCTAssertTrue([game isDrawn]);
    XCTAssertFalse([game isInPlay]);
    XCTAssertEqual(1, game.drawn);
}

-(void)testWhenResetWithComputerFirstThenGameIsStarted
{
    DTIGame* game = [[DTIGame alloc] init];
    [game resetWithComputerFirst];
    XCTAssertFalse(game.isDrawn);
    XCTAssertFalse(game.isLost);
    XCTAssertTrue([game isInPlay]);
    XCTAssertEqual(1, game.getPlaysInOrder.count);
}

-(void)testWhenResetWithPlayerFirstThenGameIsResetButNotStarted
{
    DTIGame* game = [[DTIGame alloc] init];
    [game resetWithPlayerFirst];
    XCTAssertFalse(game.isDrawn);
    XCTAssertFalse(game.isLost);
    XCTAssertTrue([game isInPlay]);
    XCTAssertEqual(0, game.getPlaysInOrder.count);
}

+(void)playSequence:(NSString*)sequence on:(DTIGameBoard*)board
{
    for( int i = 0; i < 9; ++i )
    {
        unichar c = [sequence characterAtIndex:i];
        if( c != '-' )
        {
            [board play:[GameTests getPlayerForCharacter:c
                         withXAs:board.computer] inSquare:i];
        }
    }
}

+(id)getPlayerForCharacter:(unichar)character
                           withXAs:(DTIPlayer*)player
{
    switch(character)
    {
        case 'X':
            return player;
        case 'O':
            return player.opponent;
        default:
            return [NSNull null];
    }
}

@end

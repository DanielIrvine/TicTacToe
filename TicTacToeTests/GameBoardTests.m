//
//  TicTacToeTests.m
//  TicTacToeTests
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DTIGameBoard.h"
#import "DTISequenceGenerator.h"

@interface GameBoardTests : XCTestCase
{
    DTISequenceGenerator* _seqGen;
}

@end

@implementation GameBoardTests

-(void)setUp
{
    [super setUp];
    _seqGen = [[DTISequenceGenerator alloc] init];
}

-(void)testWhenWinningSequencePlayedThenIsWon
{
    for( NSString* sequence in [_seqGen generateAllWinningSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:'X'];
        [self playSequence:sequence on:board];
        XCTAssertTrue([board isWon]);
    }
}

-(void)testWhenDrawSequencePlayedThenIsDrawn
{
    for( NSString* sequence in [_seqGen generateDrawSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:'X'];
        [self playSequence:sequence on:board];

        if(![board isDrawn])
        {
            NSLog(@"Sequence:%@", sequence);
        }
        XCTAssertTrue([board isDrawn]);
    }
}

-(void)testWhenComputerPlayerCanWinThenWinningMoveIsTaken
{
    for( NSString* sequence in [_seqGen generateOneMoveFromWinningSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:'X'];
        [self playSequence:sequence on:board];
        [board playBestMove];
        XCTAssertTrue([board isWon]);
    }
}

-(void)playSequence:(NSString*)sequence on:(DTIGameBoard*)board
{
    for( int i = 0; i < 9; ++i )
    {
        [board play:[sequence characterAtIndex:i] inSquare:i];
    }
}


@end

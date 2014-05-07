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

-(void)testWhenComputerPlayerCanBlockThenBlockIsTaken
{
    for( NSString* sequence in [_seqGen generateOneMoveFromWinningSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:'O'];
        [self playSequence:sequence on:board];
        [board playBestMove];

        // TODO: possibly move some of this logic out
        NSArray* whatIf = [self blockSquare:[board.lastBlockedSquare integerValue]
                                 inSequence:sequence];

        bool wasBlocked = false;
        NSNumber* otherPlayer = [NSNumber numberWithChar:'X'];
        for( NSArray* winningTriplet in board.winningTriplets )
        {
            // TODO: simplify this somehow
            if( [whatIf[[winningTriplet[0] integerValue]] isEqualToValue:otherPlayer]
               && [whatIf[[winningTriplet[1] integerValue]] isEqualToValue:otherPlayer]
               && [whatIf[[winningTriplet[2] integerValue]] isEqualToValue:otherPlayer] )
            {
                wasBlocked = true;
                break;
            }
        }
        XCTAssertTrue(wasBlocked);
    }
}

-(void)testWhenComputerPlayerCanForkThenForkIsTaken
{
    for( NSString* sequence in [_seqGen generateForkableSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:'X'];
        [self playSequence:sequence on:board];
        [board playBestMove];

        // TODO: what to test here....search for two X-X patterns
    }
}


-(void)playSequence:(NSString*)sequence on:(DTIGameBoard*)board
{
    for( int i = 0; i < 9; ++i )
    {
        unichar c = [sequence characterAtIndex:i];
        if( c != '-' )
        {
            [board play:c inSquare:i];
        }
    }
}

// @remarks This not only blocks but changes the output type
// It's also not very clear that it'll insert a 'O', maybe that should be a parameter
-(NSArray*)blockSquare:(NSInteger)square inSequence:(NSString*)sequence
{
    NSMutableArray* sequenceArray = [[NSMutableArray alloc] init];
    for( int i = 0; i < 9; ++i )
    {
        if( i == square ) [sequenceArray addObject:[NSNumber numberWithChar:'X']];
        else [sequenceArray addObject:[NSNumber numberWithChar:[sequence characterAtIndex:i]]];
    }
    return sequenceArray;
}

@end

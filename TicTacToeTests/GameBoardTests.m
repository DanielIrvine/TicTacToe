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
        NSMutableArray* seqSplit = [self splitSequenceIntoArray:sequence];
        seqSplit[board.lastBlockedSquare.integerValue] = [NSNumber numberWithChar:'X'];

        bool wasBlocked = false;
        NSNumber* otherPlayer = [NSNumber numberWithChar:'X'];
        for( NSArray* winningTriplet in board.winningTriplets )
        {
            // TODO: simplify this somehow
            if( [seqSplit[[winningTriplet[0] integerValue]] isEqualToValue:otherPlayer]
               && [seqSplit[[winningTriplet[1] integerValue]] isEqualToValue:otherPlayer]
               && [seqSplit[[winningTriplet[2] integerValue]] isEqualToValue:otherPlayer] )
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

        // FIXME: repeated code from previous test
        NSMutableArray* seqSplit = [self splitSequenceIntoArray:sequence];
        seqSplit[board.lastBlockedSquare.integerValue] = [NSNumber numberWithChar:'X'];

        // TODO: save off this other player in the board somehow
        NSNumber* otherPlayer = [NSNumber numberWithChar:'O'];
        int rowsWithTwoXs = 0;
        for( NSArray* winningTriplet in board.winningTriplets )
        {
            int xCount = 0;
            xCount += [self increaseIf:seqSplit[[winningTriplet[0] integerValue]]
                               matches:board.player
                andDecreaseIfItMatches:otherPlayer];
            xCount += [self increaseIf:seqSplit[[winningTriplet[1] integerValue]]
                               matches:board.player
                andDecreaseIfItMatches:otherPlayer];
            xCount += [self increaseIf:seqSplit[[winningTriplet[2] integerValue]]
                               matches:board.player
                andDecreaseIfItMatches:otherPlayer];

            if(xCount == 2)
            {
                rowsWithTwoXs++;
            }

        }

        XCTAssertTrue(rowsWithTwoXs == 2);
    }
}

-(int)increaseIf:(NSNumber*)squareValue
       matches:(NSNumber*)player
andDecreaseIfItMatches:(NSNumber*)otherPlayer
{
    if([squareValue isEqualToNumber:player]) return 1;
    if([squareValue isEqualToNumber:otherPlayer]) return -1;
    return 0;
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

-(NSMutableArray*)splitSequenceIntoArray:(NSString*)sequence
{
    NSMutableArray* sequenceArray = [[NSMutableArray alloc] init];
    for( int i = 0; i < 9; ++i )
    {
        [sequenceArray addObject:[NSNumber numberWithChar:[sequence characterAtIndex:i]]];
    }
    return sequenceArray;
}

@end

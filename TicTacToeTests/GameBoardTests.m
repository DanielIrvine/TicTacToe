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
#import "DTIPlayer.h"

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
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer x]];
        [self playSequence:sequence on:board];
        XCTAssertTrue([board isWon]);
    }
}

-(void)testWhenDrawSequencePlayedThenIsDrawn
{
    for( NSString* sequence in [_seqGen generateDrawSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer x]];
        [self playSequence:sequence on:board];
        XCTAssertTrue([board isDrawn]);
    }
}

-(void)testWhenComputerPlayerCanWinThenWinningMoveIsTaken
{
    for( NSString* sequence in [_seqGen generateOneMoveFromWinningSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer x]];
        [self playSequence:sequence on:board];
        [board playBestMove];
        XCTAssertTrue([board isWon]);
    }
}

-(void)testWhenComputerPlayerCanBlockThenBlockIsTaken
{
    for( NSString* sequence in [_seqGen generateOneMoveFromWinningSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer o]];
        [self playSequence:sequence on:board];
        [board playBestMove];

        NSMutableArray* seqSplit = [self repeatLastMoveAsXInSequence:sequence
                                                                  on:board];

        bool wasBlocked = false;
        for( NSArray* winningTriplet in board.winningTriplets )
        {
            if( seqSplit[[winningTriplet[0] integerValue]] == [DTIPlayer x]
               && seqSplit[[winningTriplet[1] integerValue]] == [DTIPlayer x]
               && seqSplit[[winningTriplet[2] integerValue]] == [DTIPlayer x] )
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
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer x]];
        [self playSequence:sequence on:board];
        [board playBestMove];

        NSMutableArray* seqSplit = [self repeatLastMoveAsXInSequence:sequence
                                                                  on:board];

        int rowsWithTwoXs = 0;
        for( NSArray* winningTriplet in board.winningTriplets )
        {
            int xCount = 0;
            xCount += [self increaseIf:seqSplit[[winningTriplet[0] integerValue]]
                               matches:[DTIPlayer x]
                andDecreaseIfItMatches:[DTIPlayer o]];
            xCount += [self increaseIf:seqSplit[[winningTriplet[1] integerValue]]
                               matches:[DTIPlayer x]
                andDecreaseIfItMatches:[DTIPlayer o]];
            xCount += [self increaseIf:seqSplit[[winningTriplet[2] integerValue]]
                               matches:[DTIPlayer x]
                andDecreaseIfItMatches:[DTIPlayer o]];

            if(xCount == 2)
            {
                rowsWithTwoXs++;
            }

        }

        XCTAssertTrue(rowsWithTwoXs == 2);
    }
}

-(NSMutableArray*)repeatLastMoveAsXInSequence:(NSString*)sequence
                                           on:(DTIGameBoard*)board
{
    NSMutableArray* seqSplit = [self splitSequenceIntoArray:sequence];
    seqSplit[board.lastPlayedSquare.integerValue] = [DTIPlayer x];
    return seqSplit;
}

-(int)increaseIf:(DTIPlayer*)squareValue
       matches:(DTIPlayer*)player
andDecreaseIfItMatches:(DTIPlayer*)otherPlayer
{
    if(squareValue == player) return 1;
    if(squareValue == otherPlayer) return -1;
    return 0;
}

-(void)playSequence:(NSString*)sequence on:(DTIGameBoard*)board
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
        [sequenceArray addObject:[self getPlayerForCharacter:[sequence characterAtIndex:i]]];
    }
    return sequenceArray;
}

-(DTIPlayer*)getPlayerForCharacter:(unichar)character
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

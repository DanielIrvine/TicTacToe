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
#import "DTISequenceGenerator.h"
#import "DTIPlayer.h"

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
        [GameBoardTests playSequence:sequence on:board];
        XCTAssertTrue([board isWon]);
    }
}

-(void)testWhenDrawSequencePlayedThenIsDrawn
{
    for( NSString* sequence in [_seqGen generateDrawSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer x]];
        [GameBoardTests playSequence:sequence on:board];
        XCTAssertTrue([board isDrawn]);
    }
}

-(void)testWhenComputerPlayerCanWinThenWinningMoveIsTaken
{
    for( NSString* sequence in [_seqGen generateOneMoveFromWinningSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer x]];
        [GameBoardTests playSequence:sequence on:board];
        [board playBestMove];
        XCTAssertTrue([board isWon]);
    }
}

-(void)testWhenComputerPlayerCanBlockThenBlockIsTaken
{
    for( NSString* sequence in [_seqGen generateOneMoveFromWinningSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer o]];
        [GameBoardTests playSequence:sequence on:board];
        [board playBestMove];

        NSMutableArray* seqSplit = [self repeatLastMoveAs:[DTIPlayer x]
                                               inSequence:sequence
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
        [GameBoardTests playSequence:sequence on:board];
        [board playBestMove];

        NSMutableArray* seqSplit = [self repeatLastMoveAs:[DTIPlayer x]
                                               inSequence:sequence
                                                       on:board];

        int rowsWithTwoXs = 0;
        for( NSArray* winningTriplet in board.winningTriplets )
        {
            if( [self thereAreTwoSquaresForPlayer:[DTIPlayer x]
                                            inRow:winningTriplet
                                           within:seqSplit] )
            {
                rowsWithTwoXs++;
            }

        }

        XCTAssertTrue(rowsWithTwoXs == 2);
    }
}

-(void)testWhenComputerPlayerMustBlockForkThenForkIsBlocked
{
    for( NSString* sequence in [_seqGen generateForkableSequences] )
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer o]];
        [GameBoardTests playSequence:sequence on:board];
        [board playBestMove];

        NSMutableArray* seqSplit = [self repeatLastMoveAs:[DTIPlayer o]
                                               inSequence:sequence
                                                       on:board];

        // The move has been successful if X must now move in exactly one
        // square and making that move will not result in a fork for X
        for( NSArray* winningTriplet in board.winningTriplets )
        {
            if( [self thereAreTwoSquaresForPlayer:[DTIPlayer o]
                                            inRow:winningTriplet
                                           within:seqSplit] )
            {
                // Move x into this square
                NSInteger nextMoveForX = [[self getEmptySquareFrom:winningTriplet
                                                       inSequence:seqSplit] integerValue];
                seqSplit[nextMoveForX] = [DTIPlayer x];

                // Check that a fork was not created
                NSInteger validPlaysForX = 0;
                for( NSArray* winningTripletForX in board.winningTriplets )
                {
                    if( [self thereAreTwoSquaresForPlayer:[DTIPlayer x]
                                                    inRow:winningTripletForX
                                                   within:seqSplit])
                    {
                        validPlaysForX++;
                    }
                }

                XCTAssertTrue(validPlaysForX < 2);
                return;
            }
        }

        XCTFail(@"Player O should have had two-in-a-row but this was not found.");
    }
}

-(void)testWhenTheCenterIsEmptyThenTheCenterIsPlayed
{
    static const NSInteger kCenterSquare = 4;

    [self testSequencesAndExpectedPlays:@{@"X--------" : @(kCenterSquare),
                                          @"-X-------" : @(kCenterSquare),
                                          @"--X------" : @(kCenterSquare),
                                          @"---X-----" : @(kCenterSquare),
                                          @"-----X---" : @(kCenterSquare),
                                          @"------X--" : @(kCenterSquare),
                                          @"-------X-" : @(kCenterSquare),
                                          @"--------X" : @(kCenterSquare),
                                          }
                                     as:[DTIPlayer x]];
}

-(void)testWhenACornerIsPlayedThenTheOppositeCornerIsPlayed
{
    [self testSequencesAndExpectedPlays:@{@"O---X----": @8,
                                          @"--O-X----": @6,
                                          @"----X-O--": @2,
                                          @"----X---O": @0
                                          }
                                     as:[DTIPlayer x]];
}

-(void)testWhenACornerIsEmptyThenItIsPlayed
{
    [self testSequencesAndExpectedPlays:@{@"O---X---X": @2,
                                          @"--X-X-O--": @8,
                                          }
                                     as:[DTIPlayer o]];
}

-(void)testWhenOnlySidesAreEmptyThenItIsPlayed
{
    [self testSequencesAndExpectedPlays:@{@"OOXXXOO-X": @7,
                                          }
                                     as:[DTIPlayer x]];
}

-(void)testWhenBoardIsEmptyThenAnySquareIsPlayed
{
    DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:[DTIPlayer x]];
    [board playBestMove];
    XCTAssertNotNil(board.lastPlayedSquare);
}

-(void)testWhenPlayingAfterCornerOpeningMoveThenCenterIsPlayed
{
    [self testSequencesAndExpectedPlays:@{@"O---X---X": @2,
                                          @"--X-X-O--": @8,
                                          }
                                     as:[DTIPlayer o]];
}

-(void)testWhenPlayingAfterCenterOpeningMoveThenCornerIsPlayed
{
    [self testSequencesAndExpectedPlays:@{@"----X----": @0,
                                          }
                                     as:[DTIPlayer o]];
}

-(void)testSequencesAndExpectedPlays:(NSDictionary*)plays as:(DTIPlayer*)player
{
    for( NSString* sequence in plays )
    {
        NSInteger square = [plays[sequence] integerValue];
        [self expectPlayInSquare:square afterSequence:sequence as:player];
    }
}

-(void)expectPlayInSquare:(NSInteger)square
            afterSequence:(NSString*)sequence
                       as:(DTIPlayer*)player
{
    DTIGameBoard* board = [[DTIGameBoard alloc] initWithComputerPlayerAs:player];
    [GameBoardTests playSequence:sequence on:board];
    [board playBestMove];
    XCTAssertEqual(board.lastPlayedSquare.integerValue, square);
}


-(NSNumber*)getEmptySquareFrom:(NSArray*)triplet inSequence:(NSArray*)sequence
{
    for( NSNumber* index in triplet )
    {
        if(sequence[index.integerValue] == [DTIPlayer unplayed])
            return index;
    }
    return nil;
}
-(NSMutableArray*)repeatLastMoveAs:(DTIPlayer*)player
                        inSequence:(NSString*)sequence
                                on:(DTIGameBoard*)board
{
    NSMutableArray* seqSplit = [self splitSequenceIntoArray:sequence];
    seqSplit[board.lastPlayedSquare.integerValue] = player;
    return seqSplit;
}

-(bool)thereAreTwoSquaresForPlayer:(DTIPlayer*)player
                             inRow:(NSArray*)triplet
                            within:(NSArray*)seqSplit
{
    int squareCount = 0;
    squareCount += [self increaseIf:seqSplit[[triplet[0] integerValue]]
                       matches:player
        andDecreaseIfItMatches:[player opponent]];
    squareCount += [self increaseIf:seqSplit[[triplet[1] integerValue]]
                            matches:player
             andDecreaseIfItMatches:[player opponent]];
    squareCount += [self increaseIf:seqSplit[[triplet[2] integerValue]]
                            matches:player
             andDecreaseIfItMatches:[player opponent]];
    return squareCount == 2;
}

-(int)increaseIf:(DTIPlayer*)squareValue
       matches:(DTIPlayer*)player
andDecreaseIfItMatches:(DTIPlayer*)otherPlayer
{
    if(squareValue == player) return 1;
    if(squareValue == otherPlayer) return -1;
    return 0;
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

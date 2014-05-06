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

@interface TicTacToeTests : XCTestCase

@end

@implementation TicTacToeTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void)testThatGameIsWon
{
    DTISequenceGenerator* seqGen = [[DTISequenceGenerator alloc] init];
    for( NSString* sequence in [seqGen generateAllWinningSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] init];
        [self playSequence:sequence on:board];
        XCTAssertTrue([board isWon]);
    }
}

-(void)testThatGameIsDrawn
{
    DTISequenceGenerator* seqGen = [[DTISequenceGenerator alloc] init];
    for( NSString* sequence in [seqGen generateDrawSequences])
    {
        DTIGameBoard* board = [[DTIGameBoard alloc] init];
        [self playSequence:sequence on:board];
        XCTAssertTrue([board isDrawn]);
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

//
//  TicTacToeTests.m
//  TicTacToeTests
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DTIGameBoard.h"

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
    NSArray* rowWins = @[@"XXX------", @"---XXX---", @"------XXX"];
    NSArray* columnWins = @[@"X--X--X--", @"-X--X--X-", @"--X--X--X"];
    NSArray* diagonalWins = @[@"X---X---X", @"--X-X-X--"];

    NSArray* allWins = [[rowWins arrayByAddingObjectsFromArray:columnWins]
                                 arrayByAddingObjectsFromArray:diagonalWins];

    for( NSString* sequence in allWins)
    {
        [self runTestForGameSequence:sequence];
    }
}

-(void)runTestForGameSequence:(NSString*)sequence
{
    DTIGameBoard* board = [[DTIGameBoard alloc] init];
    for( int i = 0; i < 9; ++i )
    {
        [board play:[sequence characterAtIndex:i] inSquare:i];
    }
    XCTAssertTrue([board isWon]);
}


@end

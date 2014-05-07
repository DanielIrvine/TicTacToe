//
//  DTIDrawSequenceGenerator.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTISequenceGenerator.h"

@implementation DTISequenceGenerator

-(id)init
{
    if(self = [super init])
    {
        _regexRange = NSMakeRange(0, 9);
        _xRegex = [NSRegularExpression regularExpressionWithPattern:@"X"
                                                            options:0
                                                              error:nil];
    }

    return self;
}

-(NSArray*)generateAllWinningSequences
{
    NSArray* rowWins = @[@"XXX------", @"---XXX---", @"------XXX"];
    NSArray* columnWins = @[@"X--X--X--", @"-X--X--X-", @"--X--X--X"];
    NSArray* diagonalWins = @[@"X---X---X", @"--X-X-X--"];

    return [[rowWins arrayByAddingObjectsFromArray:columnWins]
                      arrayByAddingObjectsFromArray:diagonalWins];
}


-(NSArray*)duplicateXWinsWithOWins:(NSArray*)xWins
{
    NSMutableArray* oWins = [[NSMutableArray alloc] init];

    for( NSString* xWin in xWins )
        [oWins addObject:[xWin stringByReplacingOccurrencesOfString:@"X" withString:@"O"]];

    return [xWins arrayByAddingObjectsFromArray:oWins];
}

-(NSArray*)generateDrawSequences
{
    // A draw sequence (for X) must have either 4 or 5 X's,
    // but not contain any winning sequences.
    // So create all permutations of 4 or 5 Xs and then remove
    // winning elements
    NSArray* winningSequences = [self generateAllWinningSequences];
    winningSequences = [self duplicateXWinsWithOWins:winningSequences];
    NSMutableArray* drawSequences = [[NSMutableArray alloc] init];

    // Permutation is done by using a binary representation
    
    NSInteger lowestCandidate = pow(2,4) - 1; // lowest sequence is 1111 == 10000 - 1
    NSInteger highestCandidate = pow(2,9) - pow(2,4); // highest is 111110000

    for(int i = lowestCandidate; i <= highestCandidate; ++i )
    {
        if([self fourOrFiveXsInSequenceNumber:i])
        {
            NSString* sequence = [self generateSequenceFromValue:i];

            if( [self testSequence:sequence isNotWinning:winningSequences])
            {
                [drawSequences addObject:sequence];
            }
        }
    }

    return drawSequences;
}

-(NSArray*)generateOneMoveFromWinningSequences
{
    NSArray* winningSequences = [self generateAllWinningSequences];

    NSMutableArray* oneMoveFromWinning = [[NSMutableArray alloc] init];

    for( NSString* sequence in winningSequences )
    {
        NSArray *matches = [_xRegex matchesInString:sequence
                                            options:0
                                              range:_regexRange];

        for ( NSTextCheckingResult* match in matches )
        {
            NSMutableString* newSequence = [[NSMutableString alloc] initWithString:sequence];
            [newSequence replaceCharactersInRange:match.range withString:@"-"];
            [oneMoveFromWinning addObject:newSequence];
        }
    }

    return oneMoveFromWinning;
}

-(NSArray*)generateForkableSequences
{
    // It's just simpler to write these out. To generate them would
    // require at least two for loops which would be confusing to read.

    // It's mainly the Xs that are important, but I've added in an O so that
    // each game sequence is "valid". Note that some of them (like the first)
    // would never get played by optimally-playing players
    return @[@"X---X---O",
             @"X---OX---",
             @"X---O--X-",
             @"X---O---X",
             @"-X-XO----",
             @"-X--OX---",
             @"-X--O-X--",
             @"-X--O---X",
             @"--XXO----",
             @"--X-X-O--",
             @"--X-O-X--",
             @"--X-O--X-"];
}

-(NSString*)generateSequenceFromValue:(NSInteger)value
{
    char chars[9];
    for( int i = 8; i >= 0; --i)
    {
        if( value % 2 == 1)
            chars[i] = 'X';
        else
            chars[i] = 'O'; // NB Game sequence must be complete to be played

        value >>= 1;
    }

    return [NSString stringWithCString:chars encoding:NSASCIIStringEncoding];
}

// @remarks There are definitely quicker ways of doing this, but it's clear
-(bool)fourOrFiveXsInSequenceNumber:(NSInteger)value
{
    NSInteger count = 0;
    for(int i = 0; i < 9; ++i)
    {
        if( value % 2 == 1)
            count++;

        value >>= 1;
    }

    return count == 4 || count == 5;
}

-(bool)testSequence:(NSString*)sequence
       isNotWinning:(NSArray*)winningSequences
{
    for( NSString* winningSequence in winningSequences )
    {
        if( [self testSequence:sequence matches:winningSequence] )
        {
            return false;
        }
    }

    return true;
}

-(bool)testSequence:(NSString*)sequence matches:(NSString*)winningSequence
{
    for(int i = 0; i < 9; ++i)
    {
        if([self charIsXInSequence:winningSequence atSquare:i]
           && ![self charIsXInSequence:sequence atSquare:i])
        {
            return false;
        }
    }

    return true;
}

-(bool)charIsXInSequence:(NSString*)sequence atSquare:(NSInteger)square
{
    return [sequence characterAtIndex:square] == 'X';
}
@end

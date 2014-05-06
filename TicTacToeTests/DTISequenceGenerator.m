//
//  DTIDrawSequenceGenerator.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTISequenceGenerator.h"

@implementation DTISequenceGenerator

-(NSArray*)generateAllWinningSequences
{
    NSArray* rowWins = @[@"XXX------", @"---XXX---", @"------XXX"];
    NSArray* columnWins = @[@"X--X--X--", @"-X--X--X-", @"--X--X--X"];
    NSArray* diagonalWins = @[@"X---X---X", @"--X-X-X--"];

    NSArray* xWins = [[rowWins arrayByAddingObjectsFromArray:columnWins]
                      arrayByAddingObjectsFromArray:diagonalWins];

    NSArray* oWins = [self convertXWinsToOWins:xWins];

    return [xWins arrayByAddingObjectsFromArray:oWins];
}

-(NSArray*)convertXWinsToOWins:(NSArray*)xWins
{
    NSMutableArray* oWins = [[NSMutableArray alloc] init];

    for( NSString* xWin in xWins )
        [oWins addObject:[xWin stringByReplacingOccurrencesOfString:@"X" withString:@"O"]];

    return oWins;
}

-(NSArray*)generateDrawSequences
{
    // A draw sequence (for X) must have either 4 or 5 X's,
    // but not contain any winning sequences.
    // So create all permutations of 4 or 5 Xs and then remove
    // winning elements
    NSArray* winningSequences = [self generateAllWinningSequences];
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

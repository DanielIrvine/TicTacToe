//
//  DTIGameBoard.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIGameBoard.h"

@implementation DTIGameBoard

-(id)init
{
    if(self = [super init])
    {
        _squares = [[NSMutableArray alloc] initWithCapacity:9];
    }
    return self;
}

-(bool)isWon
{

    return [self isWonInRow] || [self isWonInColumn] || [self isWonInDiagonal];
}

-(bool)isWonInRow
{
    return [self threeSquaresAreEqual:0:1:2]
    || [self threeSquaresAreEqual:3:4:5]
    || [self threeSquaresAreEqual:6:7:8];
}

-(bool)isWonInColumn
{
    return [self threeSquaresAreEqual:0:3:6]
    || [self threeSquaresAreEqual:1:4:7]
    || [self threeSquaresAreEqual:2:5:8];
}

-(bool)isWonInDiagonal
{
    return [self threeSquaresAreEqual:0:4:8]
    || [self threeSquaresAreEqual:2:4:6];
}

-(bool)threeSquaresAreEqual:(NSInteger)one
                           :(NSInteger)two
                           :(NSInteger)three
{
    return _squares[one] != nil
    && [_squares[one] isEqualToValue:_squares[two]]
    && [_squares[one] isEqualToValue:_squares[three]];
}

-(void)play:(unichar)player inSquare:(NSInteger)square
{
    _squares[square] = [NSNumber numberWithChar:player];
}
@end

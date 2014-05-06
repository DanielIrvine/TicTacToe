//
//  DTIGameBoard.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIGameBoard.h"

@implementation DTIGameBoard

-(id)initWithComputerPlayerAs:(unichar)player
{
    if(self = [super init])
    {
        _squares = [[NSMutableArray alloc] initWithCapacity:9];
        _player = @(player);

        _winningTriplets = @[@[@0,@1,@2],
                             @[@3,@4,@5],
                             @[@6,@7,@8],
                             @[@0,@3,@6],
                             @[@1,@4,@7],
                             @[@2,@5,@8],
                             @[@0,@4,@8],
                             @[@2,@4,@6]];
    }
    return self;
}

-(bool)isWon
{
    for( NSArray* winningTriplet in _winningTriplets )
    {
        if( [self threeSquaresAreEqual:[winningTriplet[0] integerValue]
                                      :[winningTriplet[1] integerValue]
                                      :[winningTriplet[2] integerValue]])
        {
            return true;
        }
    }
    return false;
}

-(bool)isDrawn
{
    return [self noSquaresEmpty] && ![self isWon];
}

-(bool)noSquaresEmpty
{
    for(int i = 0; i < 9; ++i)
        if(_squares[i] == nil)
            return false;

    return true;
}

-(bool)threeSquaresAreEqual:(NSInteger)one
                           :(NSInteger)two
                           :(NSInteger)three
{
    return _squares[one] != nil
    && [_squares[one] isEqualToValue:_squares[two]]
    && [_squares[one] isEqualToValue:_squares[three]];
}

-(bool)twoSquaresAreEqual:(NSInteger)one
                         :(NSInteger)two
{
    return _squares[one] != nil && [_squares[one] isEqualToValue:_squares[two]];
}

-(void)play:(unichar)player inSquare:(NSInteger)square
{
    _squares[square] = @(player);
}

-(void)playBestMove
{
    for( NSArray* winningTriplet in _winningTriplets )
    {
        NSNumber* move = [self tryFindEmptySpaceinSquares:[winningTriplet[0] integerValue]
                                                         :[winningTriplet[1] integerValue]
                                                         :[winningTriplet[2] integerValue]];

        if( move != nil )
        {
            NSLog(@"Sequence:%@", _squares);

            _squares[[move integerValue]] = _player;
        }
    }
}


-(NSNumber*)tryFindEmptySpaceinSquares:(NSInteger)one
                                    :(NSInteger)two
                                    :(NSInteger)three
{
    if(_squares[three] == nil
       && [self twoSquaresAreEqual:one :two]
       && [_squares[one] isEqualToValue:_player] )
        return @(three);
    else if(_squares[one] == nil
            && [self twoSquaresAreEqual:two:three]
            && [_squares[two] isEqualToValue:_player] )
        return @(one);
    else if(_squares[two] == nil
            && [self twoSquaresAreEqual:one:three]
            && [_squares[three] isEqualToValue:_player] )
        return @(two);

    return nil;
}
@end

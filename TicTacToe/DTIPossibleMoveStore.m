//
//  DTIPossibleMoveStore.m
//  TicTacToe
//
//  Created by Daniel Irvine on 12/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIPossibleMoveStore.h"
#import "DTIPossibleMove.h"
#import "DTIGameBoard.h"

static NSArray* rotations;

@implementation DTIPossibleMoveStore

-(id)init
{
    if(self = [super init])
    {
        _store = [[NSMutableDictionary alloc] init];
        _rotations = @[ // rotations
                        @[@2, @5, @8, @1, @4, @7, @0, @3, @6],
                        @[@8, @7, @6, @5, @4, @3, @2, @1, @0],
                        @[@6, @3, @0, @7, @4, @1, @8, @5, @2],
                        // mirrored
                        @[@2, @1, @0, @5, @4, @3, @8, @7, @6],
                        @[@6, @7, @8, @3, @4, @5, @0, @1, @2],
                        @[@8, @5, @2, @7, @4, @1, @6, @3, @0],
                        @[@0, @3, @6, @1, @4, @7, @2, @5, @8]];

    }
    return self;
}
-(DTIPossibleMove*)getAlreadyCalculatedValueFor:(DTIGameBoard*)gameBoard
{
    DTIPossibleMove* move = [_store objectForKey:[gameBoard description]];

    if( move == nil )
    {
        for( NSArray* rotation in _rotations)
        {
            DTIGameBoard* rotated = [gameBoard rotateBy:rotation];
            DTIPossibleMove* move = [_store objectForKey:[rotated description]];
            if(move != nil )
            {
                return [move derotateBy:rotation];
            }
        }
    }

    return move;
}

-(void)insertCalculatedMoveFor:(DTIGameBoard*)gameBoard of:(DTIPossibleMove*)move
{
    _store[[gameBoard description]] = move;
}

@end

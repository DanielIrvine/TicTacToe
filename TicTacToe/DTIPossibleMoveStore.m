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

@implementation DTIPossibleMoveStore

-(id)init
{
    if(self = [super init])
    {
        _store = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(DTIPossibleMove*)getAlreadyCalculatedValueFor:(DTIGameBoard*)gameBoard
{
    return [_store objectForKey:[gameBoard description]];
}

-(void)insertCalculatedMoveFor:(DTIGameBoard*)gameBoard of:(DTIPossibleMove*)move
{
    _store[[gameBoard description]] = move;
}

@end

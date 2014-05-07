//
//  DTISquareState.m
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIPlayer.h"

static DTIPlayer* kX;
static DTIPlayer* kO;
static DTIPlayer* kUnplayed;

@implementation DTIPlayer

+(void)initialize
{

    kX = [[DTIPlayer alloc] initWithPlayer:@"X"];
    kO = [[DTIPlayer alloc] initWithPlayer:@"O"];
    kUnplayed = [[DTIPlayer alloc] initWithPlayer:@"-"];
}

-(id)initWithPlayer:(NSString*)player
{
    if(self = [super init])
    {
        _player = player;
    }
    return self;

}

-(DTIPlayer*)opponent
{
    if (self == kX ) return kO;
    if (self == kO) return kX;
    return nil;
}

+(DTIPlayer*)x
{
    return kX;
}

+(DTIPlayer*)o
{
    return kO;
}

+(DTIPlayer*)unplayed
{
    return kUnplayed;
}

-(NSString *)description
{
    return _player;
}

-(NSString *)debugDescription
{
    return _player;
}

@end


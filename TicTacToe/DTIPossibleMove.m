//
//  DTIPossibleMove.m
//  TicTacToe
//
//  Created by Daniel Irvine on 12/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIPossibleMove.h"

@implementation DTIPossibleMove

+(DTIPossibleMove*)buildWithScore:(NSInteger)score andSquare:(NSNumber*)square
{
    DTIPossibleMove* move = [[DTIPossibleMove alloc] init];
    move.score = score;
    move.square = square;
    return move;
}

@end

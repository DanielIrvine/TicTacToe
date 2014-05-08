//
//  DTIOppositeCornerRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIOppositeCornerRule.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

static const NSInteger kCorners[4] = {0, 2, 6, 8};
static const NSInteger kOppositeCorners[4] = {8, 6, 2, 0};

@implementation DTIOppositeCornerRule

-(bool)tryPlay
{

    for( int i = 0; i < 4; ++i )
    {
        if( _squares[kCorners[i]] == [_board.player opponent]
           && _squares[kOppositeCorners[i]] == [DTIPlayer unplayed] )
        {
            [_board play:_board.player inSquare:kOppositeCorners[i]];
            return true;
        }
    }

    return false;
}
@end

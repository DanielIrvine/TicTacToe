//
//  DTIFirstMoveRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIFirstMoveRule.h"
#import "DTIGameBoard.h"

@implementation DTIFirstMoveRule

-(bool)tryPlay
{
    if( [_board allSquaresEmpty])
    {
        [_board play:_board.player inSquare:arc4random_uniform(9)];
        return true;
    }
    return false;
}
@end

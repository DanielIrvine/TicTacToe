//
//  DTICenterRule.m
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTICenterRule.h"
#import "DTIGameBoard.h"
#import "DTIPlayer.h"

static const NSInteger kCenterSquare = 4;

@implementation DTICenterRule

-(bool)tryPlay
{
    if( _squares[kCenterSquare] == [DTIPlayer unplayed] )
    {
        [_board play:_board.computer inSquare:kCenterSquare];
        return true;
    }
    return false;
}
@end

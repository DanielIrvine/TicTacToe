//
//  DTIGameBoard.h
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTIGameBoard : NSObject {
    NSMutableArray* _squares;
    NSNumber* _player;
    NSArray* _winningTriplets;
}

-(id)initWithComputerPlayerAs:(unichar)player;
-(bool)isWon;
-(bool)isDrawn;
-(void)playBestMove;

-(void)play:(unichar)player inSquare:(NSInteger)square;
@end

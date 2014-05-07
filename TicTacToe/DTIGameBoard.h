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
    NSArray* _computerPlayerRules;
}

@property (readonly) NSNumber* player;
@property (readonly) NSNumber* freeSquare;
@property (readonly) NSArray* winningTriplets;

@property (readonly) NSNumber* lastBlockedSquare;

-(id)initWithComputerPlayerAs:(unichar)player;
-(bool)isWon;
-(bool)isDrawn;
-(void)playBestMove;

-(void)play:(unichar)player inSquare:(NSInteger)square;
@end

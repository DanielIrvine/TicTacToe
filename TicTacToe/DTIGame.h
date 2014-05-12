//
//  DTIGame.h
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DTIGameBoard;
@class DTIPlayer;

@interface DTIGame : NSObject {
    NSMutableArray* _lastPlayedSquares;
}

-(void)resetWithComputerFirst;
-(void)resetWithPlayerFirst;

@property (readonly) DTIPlayer* x;
@property (readonly) DTIPlayer* computer;
@property (readonly) DTIPlayer* human;
@property DTIGameBoard* board;

-(void)touchIn:(NSInteger)square;
-(void)touchOutsideSquare;
-(NSArray*)getPlaysInOrder;

-(bool)isInPlay;

@property (readonly) NSInteger won;
@property (readonly) NSInteger lost;
@property (readonly) NSInteger drawn;

@property (readonly) bool isDrawn;
@property (readonly) bool isLost;


@end

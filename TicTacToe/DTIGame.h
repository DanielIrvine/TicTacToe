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
    DTIGameBoard* _board;
    NSMutableArray* _lastPlayedSquares;
}

-(id)initWithGameBoard:(DTIGameBoard*)board;
-(void)resetWithComputerFirst;
-(void)resetWithPlayerFirst;

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

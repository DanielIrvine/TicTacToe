//
//  DTIGameBoard.h
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DTIPlayer;

@interface DTIGameBoard : NSObject {
    NSMutableArray* _squares;
    NSArray* _computerPlayerRules;
}

@property (readonly) DTIPlayer* player;
@property (readonly) NSArray* winningTriplets;

@property (readonly) NSNumber* lastPlayedSquare;

-(id)initWithComputerPlayerAs:(DTIPlayer*)player;
-(bool)isWon;
-(bool)isDrawn;
-(bool)allSquaresEmpty;
-(void)playBestMove;

-(void)play:(DTIPlayer*)player inSquare:(NSInteger)square;
@end

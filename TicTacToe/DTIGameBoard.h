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
    NSArray* _computerPlayerRules;
}

@property (readonly) NSMutableArray* squares;
@property (readonly) DTIPlayer* computer;

@property (readonly) NSNumber* lastPlayedSquare;

-(id)initWithComputerPlayerAs:(DTIPlayer*)player;

-(id)initWithExistingBoard:(DTIGameBoard*)board
                andNewMove:(NSNumber*)move
                  asPlayer:(DTIPlayer*)player;

-(bool)isWon;
-(bool)isDrawn;
-(bool)allSquaresEmpty;
-(DTIGameBoard*)playBestMove;

-(void)play:(DTIPlayer*)player inSquare:(NSInteger)square;
-(NSArray*)availableSpaces;
-(NSArray*) winningTriplets;
@end

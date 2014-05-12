//
//  DTIGameBoard.h
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DTIPlayer;

@interface DTIGameBoard : NSObject

@property (readonly) NSMutableArray* squares;

-(id)init;
-(id)initWithExistingBoard:(DTIGameBoard*)board
                andNewMove:(NSNumber*)move
                  asPlayer:(DTIPlayer*)player;

-(bool)isWon;
-(bool)isDrawn;

-(NSArray*)availableSpaces;
-(NSArray*)winningTriplets;

-(DTIGameBoard*)rotateBy:(NSArray*)rotation;
@end

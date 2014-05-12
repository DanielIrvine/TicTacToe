//
//  DTISquareState.h
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DTIGameBoard;

@interface DTIPlayer : NSObject {
    NSString* _player;
}

+(DTIPlayer*)createOpposingPlayers;
-(id)initWithPlayer:(NSString*)player;

@property DTIPlayer* opponent;
-(DTIGameBoard*)getBestPlayFor:(DTIGameBoard*)gameBoard;

@end

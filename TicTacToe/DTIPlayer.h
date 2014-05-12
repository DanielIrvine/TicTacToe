//
//  DTISquareState.h
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DTIGameBoard;
@class DTIPossibleMoveStore;

@interface DTIPlayer : NSObject {
    NSString* _player;
    DTIPossibleMoveStore* _store;
}

+(DTIPlayer*)createOpposingPlayers;
-(id)initWithPlayer:(NSString*)player andStore:(DTIPossibleMoveStore*)store;

@property DTIPlayer* opponent;
-(NSNumber*)makeBestPlayFor:(DTIGameBoard*)gameBoard;

@end

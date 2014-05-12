//
//  DTIPossibleMoveStore.h
//  TicTacToe
//
//  Created by Daniel Irvine on 12/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

@class DTIPossibleMove;
@class DTIGameBoard;

@interface DTIPossibleMoveStore : NSObject{
    NSMutableDictionary* _store;
}

-(DTIPossibleMove*)getAlreadyCalculatedValueFor:(DTIGameBoard*)gameBoard;
-(void)insertCalculatedMoveFor:(DTIGameBoard*)gameBoard of:(DTIPossibleMove*)move;

@end

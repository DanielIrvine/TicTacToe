//
//  DTISquareState.h
//  TicTacToe
//
//  Created by Daniel Irvine on 07/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTIPlayer : NSObject {
    NSString* _player;
}

-(id)initWithPlayer:(NSString*)player;
+(DTIPlayer*)x;
+(DTIPlayer*)o;
+(DTIPlayer*)unplayed;

@end

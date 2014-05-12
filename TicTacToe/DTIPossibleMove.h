//
//  DTIPossibleMove.h
//  TicTacToe
//
//  Created by Daniel Irvine on 12/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

@interface DTIPossibleMove : NSObject

@property NSInteger score;
@property NSNumber* square;

+(DTIPossibleMove*)buildWithScore:(NSInteger)score andSquare:(NSNumber*)square;
@end

//
//  DTIPossibleMove.h
//  TicTacToe
//
//  Created by Daniel Irvine on 12/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

@interface DTIPossibleMove : NSObject

@property (readonly) NSInteger score;
@property (readonly) NSNumber* square;

+(DTIPossibleMove*)buildWithScore:(NSInteger)score andSquare:(NSNumber*)square;
-(DTIPossibleMove*)derotateBy:(NSArray*)rotation;
@end

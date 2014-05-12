//
//  DTIPossibleMove.m
//  TicTacToe
//
//  Created by Daniel Irvine on 12/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIPossibleMove.h"

@implementation DTIPossibleMove

-(id)initWithScore:(NSInteger)score andSquare:(NSNumber*)square
{
    if(self = [super init])
    {
        _score = score;
        _square = square;
    }
    return self;
}
+(DTIPossibleMove*)buildWithScore:(NSInteger)score andSquare:(NSNumber*)square
{
    return [[DTIPossibleMove alloc] initWithScore:score andSquare:square];
}


-(DTIPossibleMove*)derotateBy:(NSArray*)rotation
{
    NSNumber* previousPosition = @([rotation indexOfObject:_square]);
    return [DTIPossibleMove buildWithScore:_score
                                 andSquare:previousPosition];
}

@end

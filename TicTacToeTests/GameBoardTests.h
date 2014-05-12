#import <XCTest/XCTest.h>

@class DTISequenceGenerator;
@class DTIGameBoard;

@interface GameBoardTests : XCTestCase

+(void)playSequence:(NSString*)sequence on:(DTIGameBoard*)board;

@end
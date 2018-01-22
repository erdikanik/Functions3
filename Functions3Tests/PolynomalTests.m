//
//  PolynomalTests.m
//  Functions3
//
//  Created by Erdi Kanik on 01/10/2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Polynomal.h"

@interface PolynomalTests : XCTestCase

@end

@implementation PolynomalTests

- (void)testPolynomals
{
    Polynomal *polynomal = [[Polynomal alloc] initWithPolynomalString:@"-1x+5"];

    NSInteger result = [polynomal getPolynomalValue:-5];
    NSInteger result2 = [polynomal getPolynomalValue:-9];
    NSInteger result3 = [polynomal getPolynomalValue:4];
    NSInteger result4 = [polynomal getPolynomalValue:7];
    NSInteger result5 = [polynomal getPolynomalValue:9];
    NSInteger result6 = [polynomal getPolynomalValue:6];
    NSInteger result7 = [polynomal getPolynomalValue:-3];

    XCTAssertEqual(result, 10);
    XCTAssertEqual(result2, 14);
    XCTAssertEqual(result3, 1);
    XCTAssertEqual(result4, -2);
    XCTAssertEqual(result5, -4);
    XCTAssertEqual(result6, -1);
    XCTAssertEqual(result7, 8);

    Polynomal *polynomal2 = [[Polynomal alloc] initWithPolynomalString:@"1x+5"];

    result = [polynomal2 getPolynomalValue:-5];
    result2 = [polynomal2 getPolynomalValue:-9];
    result3 = [polynomal2 getPolynomalValue:4];
    result4 = [polynomal2 getPolynomalValue:7];

    XCTAssertEqual(result, 0);
    XCTAssertEqual(result2, -4);
    XCTAssertEqual(result3, 9);
    XCTAssertEqual(result4, 12);

    Polynomal *polynomal3 = [[Polynomal alloc] initWithPolynomalString:@"-1x^3"];

    result = [polynomal3 getPolynomalValue:-5];
    result2 = [polynomal3 getPolynomalValue:-9];
    result3 = [polynomal3 getPolynomalValue:4];
    result4 = [polynomal3 getPolynomalValue:7];

    XCTAssertEqual(result, 125);
    XCTAssertEqual(result2, 729);
    XCTAssertEqual(result3, -64);
    XCTAssertEqual(result4, -343);

    Polynomal *polynomal4 = [[Polynomal alloc] initWithPolynomalString:@"1x+-3"];

    result = [polynomal4 getPolynomalValue:-5];
    result2 = [polynomal4 getPolynomalValue:-9];
    result3 = [polynomal4 getPolynomalValue:4];
    result4 = [polynomal4 getPolynomalValue:7];

    XCTAssertEqual(result, -8);
    XCTAssertEqual(result2, -12);
    XCTAssertEqual(result3, 1);
    XCTAssertEqual(result4, 4);
}

@end

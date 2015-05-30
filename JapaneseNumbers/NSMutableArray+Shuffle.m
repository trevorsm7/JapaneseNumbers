//
//  NSMutableArray+Shuffle.m
//  CocoaTest
//
//  Created by Trevor Smith on 2/25/14.
//  Copyright (c) 2014 Trevor Smith. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"
#include <stdlib.h>

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
    uint32_t count = (uint32_t)[self count];
    for (uint32_t i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        uint32_t nElements = count - i;
        NSUInteger n = arc4random_uniform(nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end

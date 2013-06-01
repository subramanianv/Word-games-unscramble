//
//  Suffle.m
//  AppScaffold
//
//  Created by Subramanian Venkatesan on 12/27/11.
//  Copyright 2011 SRv. All rights reserved.
//

#import "Suffle.h"


@implementation NSMutableArray (Suffle)

- (void)shuffle
{
    
    static BOOL seeded = NO;
    if(!seeded)
        {
        seeded = YES;
        srandom(time(NULL));
        }
    
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end

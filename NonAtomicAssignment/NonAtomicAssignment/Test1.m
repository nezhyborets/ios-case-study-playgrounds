//
//  Test1.m
//  NonAtomicAssignment
//
//  Created by Alexei on 3/27/17.
//  Copyright © 2017 Nezhyborets. All rights reserved.
//

#import "Test1.h"


@implementation Test1 {
    NSString *stringProp;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self test];
    }

    return self;
}

- (void)test {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        dispatch_apply(10000000, dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^(size_t i) {
            stringProp = [[NSString alloc] initWithFormat:@"%lu", i];
        });
    });

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        dispatch_apply(100000, dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^(size_t i) {
            NSString *string = stringProp;
            [self print:string];
        });
    });
}


- (void)print:(NSString * __unsafe_unretained)string {
    NSLog(@"%@", string);
}

@end

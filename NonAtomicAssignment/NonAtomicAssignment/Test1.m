//
//  Test1.m
//  NonAtomicAssignment
//
//  Created by Alexei on 3/27/17.
//  Copyright © 2017 Nezhyborets. All rights reserved.
//

#import "Test1.h"

@interface Test1()
@property (nonatomic, strong) NSObject *prop;
@end

@implementation Test1 {
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self test];
    }

    return self;
}

- (void)test {
    for (int i = 0; i < 20; i++) {
        [self dispatch:[NSString stringWithFormat:@"%ul", i]];
    }
}

- (void)dispatch:(NSString *)label {
    dispatch_queue_t dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dispatchQueue, ^{
        dispatch_apply(10000000000, dispatchQueue, ^(size_t i) {
            self.prop = [[NSObject alloc] init];
        });
    });
}

- (void)print:(NSString * __unsafe_unretained)string {
    NSLog(@"%@", string);
}

@end

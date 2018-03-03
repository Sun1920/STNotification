//
//  STNotificationTestClass.m
//  STNotification
//
//  Created by 孫濤 on 2018/3/3.
//  Copyright © 2018年 me.suntao. All rights reserved.
//

#import "STNotificationTestClass.h"

@implementation STNotificationTestClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        REGISTER_OBSERVER(self, TestObserver);
    }
    return self;
}

- (void)testWithOldString:(NSString *)oldString toNewString:(NSString *)newString {
    NSLog(@"%@--%@", oldString, newString);
}

- (void)dealloc {
    UNREGISTER_ALL_OBSERVER(self);
}
@end

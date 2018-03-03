//
//  ViewController.m
//  STNotification
//
//  Created by 孫濤 on 2018/3/3.
//  Copyright © 2018年 me.suntao. All rights reserved.
//

#import "ViewController.h"
#import "STNotificationTestClass.h"

@interface ViewController ()
@property STNotificationTestClass *foo1;
@property STNotificationTestClass *foo2;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _foo1 = [STNotificationTestClass new];
        _foo2 = [STNotificationTestClass new];
        POST_EVENT(TestObserver, testWithOldString:@"old1" toNewString:@"new1");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UNREGISTER_ALL_OBSERVER(_foo1);
    UNREGISTER_ALL_OBSERVER(_foo2);
    POST_EVENT(TestObserver, testWithOldString:@"old2" toNewString:@"new2");
}

@end

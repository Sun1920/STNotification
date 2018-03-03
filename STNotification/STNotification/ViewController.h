//
//  ViewController.h
//  STNotification
//
//  Created by 孫濤 on 2018/3/3.
//  Copyright © 2018年 me.suntao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STNotificationCenter.h"

@protocol TestObserver <NSObject>
- (void)testWithOldString:(NSString *)oldString toNewString:(NSString *)newString;
@end

@interface ViewController : UIViewController


@end


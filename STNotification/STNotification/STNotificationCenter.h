//
//  STNotificationCenter.h
//  STNotification
//
//  Created by 孫濤 on 2018/3/3.
//  Copyright © 2018年 me.suntao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REGISTER_OBSERVER(observer, observerProtocol) [[STNotificationCenter defaultCenter] addObserver:observer withProtocolKey:@protocol(observerProtocol)]
#define UNREGISTER_OBSERVER(observer, observerProtocol) [[STNotificationCenter defaultCenter] removeObserver:observer withProtocolKey:@protocol(observerProtocol)]
#define UNREGISTER_ALL_OBSERVER(observer) [[STNotificationCenter defaultCenter] removeObserver:observer];

#define POST_EVENT(observerProtocol, func) \
{ \
    NSArray *__receivers = [[STNotificationCenter defaultCenter] observersWithProtocolKey:@protocol(observerProtocol)];\
    for (id receiver in __receivers) { [receiver func]; } \
}

typedef Protocol *ObserverProtocolKey;

@interface STNotificationCenter : NSObject

+ (STNotificationCenter *)defaultCenter;

- (void)addObserver:(id)observer withProtocolKey:(ObserverProtocolKey)key;
- (void)removeObserver:(id)observer withProtocolKey:(ObserverProtocolKey)key;
- (void)removeObserver:(id)observer;
- (NSArray *)observersWithProtocolKey:(ObserverProtocolKey)key;

@end

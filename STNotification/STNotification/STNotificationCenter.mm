//
//  STNotificationCenter.m
//  STNotification
//
//  Created by 孫濤 on 2018/3/3.
//  Copyright © 2018年 me.suntao. All rights reserved.
//

#import "STNotificationCenter.h"

@interface STNotificationCenter ()
{
    NSMutableDictionary<NSString *, NSMutableArray *> *_observersDictionary;
    dispatch_semaphore_t semaphore;
}
@end

@implementation STNotificationCenter

+ (STNotificationCenter *)defaultCenter
{
    static STNotificationCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[STNotificationCenter alloc] init];
    });
    
    return center;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _observersDictionary = [NSMutableDictionary dictionary];
        semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)addObserver:(id)observer withProtocolKey:(ObserverProtocolKey)key
{
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    if (![observer conformsToProtocol:key])
    {
        NSLog(@"does't conforms to protocol: %@", NSStringFromProtocol(key));
    }
    
    NSString *protocolKey = NSStringFromProtocol(key);
    NSMutableArray *observersArray = _observersDictionary[protocolKey];
    if (!observersArray)
    {
        observersArray = [NSMutableArray array];
        [_observersDictionary setObject:observersArray forKey:protocolKey];
    }
    
    BOOL isContains = [observersArray containsObject:observer];
    if (!isContains)
    {
        [observersArray addObject:observer];
    }
    
    dispatch_semaphore_signal(semaphore);
}

- (void)removeObserver:(id)observer withProtocolKey:(ObserverProtocolKey)key
{
    NSString *protocolKey = NSStringFromProtocol(key);
    [self p_removeObserver:observer withKey:protocolKey];
}

- (void)p_removeObserver:(id)observer withKey:(NSString *)key
{
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSMutableArray *observersArray = _observersDictionary[key];
    [observersArray removeObject:observer];
    dispatch_semaphore_signal(semaphore);
}

- (void)removeObserver:(id)observer
{
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [_observersDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self p_removeObserver:observer withKey:key];
    }];
    
    dispatch_semaphore_signal(semaphore);
}

- (NSArray *)observersWithProtocolKey:(ObserverProtocolKey)key
{
    NSString *protocolKey = NSStringFromProtocol(key);
    return _observersDictionary[protocolKey].copy;
}

@end

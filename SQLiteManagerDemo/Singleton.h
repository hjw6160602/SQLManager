//  Created by SaiDicaprio on 15/11/19.
//  Copyright © 2015年 SaiDicaprio. All rights reserved.


#ifndef Singleton_h
#define Singleton_h

// Singleton.h
#define singleton_interface(class) + (instancetype)shared##class;

// Singleton.m
#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
    _instance = [super allocWithZone:zone]; \
    }); \
    \
    return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
    if (_instance == nil) { \
        _instance = [[class alloc] init]; \
    } \
    \
    return _instance; \
}\
\
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}

#endif /* Singleton_h */

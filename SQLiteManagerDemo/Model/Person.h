//
//  Person.h
//  SQLite基本使用
//
//  Created by shoule on 16/9/6.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, assign) NSUInteger age;

@property (nonatomic, copy) NSString *name;

+ (instancetype)personWithDict:(NSDictionary *)dict;

/* 插入记录 */
- (BOOL)insertPerson;

/* 删除记录 */
- (BOOL)deletePerson;

/* 修改/更新记录 */
- (BOOL)updatePerson;

+ (NSArray<Person *> *)loadPersons;
@end

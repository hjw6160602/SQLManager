//
//  Person.m
//  SQLite基本使用
//
//  Created by shoule on 16/9/6.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

#import "Person.h"
#import "SQLiteManager.h"


@implementation Person

#pragma mark - 执行数据源CRUD的操作

/* 插入记录 */
- (BOOL)insertPerson{
    NSAssert(self.name != nil, @"必须要给name赋值");
    // 编写SQL语句
    NSString *sql = [NSString stringWithFormat:@"\nINSERT INTO T_Person (name, age) VALUES ('%@', %ld )",self.name,self.age];
    return [self execSQL:sql];
}

/* 删除记录 */
- (BOOL)deletePerson{
    // 编写SQL语句
    NSString *sql = [NSString stringWithFormat:@"\nDELETE FROM T_Person WHERE name IS '%@' ",self.name];
    return [self execSQL:sql];
}

/* 修改/更新记录 */
- (BOOL)updatePerson{
    // 编写SQL语句
//    NSString *sql = [NSString stringWithFormat:@"\nUPDATE T_Person SET name = '%@' WHERE age = %ld",self.name, self.age];
    NSString *sql = [NSString stringWithFormat:@"\nUPDATE T_Person SET age = %ld WHERE name = '%@'", self.age, self.name];
    
    return [self execSQL:sql];
}

+ (NSArray<Person *> *)loadPersons{
    NSString *sql = @"SELECT * FROM T_Person";
    NSLog(@"%@", sql);
    NSArray *dictArr = [[SQLiteManager sharedSQLiteManager] execQuerySQL:sql];

    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *dict in dictArr) {
        [models addObject:[Person personWithDict:dict]];
    }
    return models;
}

/* 执行SQL语句 */
- (BOOL)execSQL:(NSString *)sql{
    NSLog(@"%@", sql);
    return [[SQLiteManager sharedSQLiteManager] execSQL:sql];
}

/* 字典转模型 */
+ (instancetype)personWithDict:(NSDictionary *)dict{
    Person *person = [[Person alloc]init];
    [person setValuesForKeysWithDictionary:dict];
    return person;
}

/* 忽略属性中没有的字典Key */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

// 决定了实例对象的输出结果
- (NSString *)description{
    // 下面代码会引发死循环，不要在description 做输出
    // NSLog(@"%@", self);
    return [NSString stringWithFormat:@"age = %ld, name = %@", self.age, self.name];
}

@end

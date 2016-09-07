//
//  SQLiteManager.h
//  SQLite基本使用
//
//  Created by shoule on 16/9/6.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface SQLiteManager : NSObject
singleton_interface(SQLiteManager)

/**
 * @func   打开数据库
 * @param  filename: 需要打开的数据库文件的路径
 * @param  ppDb: 打开之后的数据库对象(指针)
 * @note   以后所有的数据库操作，都必须要拿到这个ppDb指针才能进行相关操作
 */
- (void)openDB:(NSString *)SQLiteName;

/**
 * @func   数据库建表
 * @param  tableName: 表的名字
 */
- (BOOL)createTable:(NSString *)tableName;

/**
 * @func   执行除了查询以外的sql语句
 * @param  需要执行的sql语句
 * @return 是否执行成功
 */
- (BOOL)execSQL:(NSString *)sql;

/**
 * @func   执行除了查询sql语句
 * @param  需要执行的sql语句
 * @return 是否执行成功
 */
- (NSArray<NSDictionary *> *)execQuerySQL:(NSString *)sql;

@end

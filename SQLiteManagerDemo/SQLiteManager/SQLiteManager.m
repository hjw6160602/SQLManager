//
//  SQLiteManager.m
//  SQLite基本使用
//
//  Created by shoule on 16/9/6.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

#import "SQLiteManager.h"
#import <sqlite3.h>

@interface SQLiteManager()
/** 全局数据库对象 */
@property sqlite3 *db;
@end


@implementation SQLiteManager
singleton_implementation(SQLiteManager)

- (void)openDB:(NSString *)SQLiteName{
    //0.拿到数据库的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    path = [path stringByAppendingPathComponent:SQLiteName];
    NSLog(@"\n%@",path);
    
    const char *cPath = [path cStringUsingEncoding:NSUTF8StringEncoding];

    //1. 打开数据库
    //open方法特点：如果指定路径对应的数据库文件已存在，就会直接打开，如果不存在就创建一个新的文件
    if (sqlite3_open(cPath, &_db) == SQLITE_OK ){
        NSLog(@"打开数据库成功");
    }
}

- (BOOL)createTable:(NSString *)tableName{
    //1. 编写SQL语句
    
    NSString *sql = @"\nCREATE TABLE IF NOT EXISTS T_";
    
    sql = [sql stringByAppendingString:tableName];
    NSString *content = @" ( \n\
                            id   INTEGER PRIMARY KEY AUTOINCREMENT, \n\
                            name TEXT, \n\
                            age  INTEGER \n\
                        )";
    sql = [sql stringByAppendingString:content];
    
    NSLog(@"%@",sql);
    
    //2. 执行SQL语句
    BOOL isSucceed = [self execSQL:sql];
    if (isSucceed){ NSLog(@"创建表成功"); }
    else{  NSLog(@"创建表失败"); }
    return isSucceed;
}

/**
 * @func   执行除了查询以外的sql语句
 * @param  需要执行的sql语句
 * @return 是否执行成功
 */
- (BOOL)execSQL:(NSString *)sql{
    const char *cSql= [sql cStringUsingEncoding:NSUTF8StringEncoding];
    //在SQLite3中，除了查询意外（创建C、更新U、删除D、）都使用一个函数
    /* @param
     * 1. 已经打开的数据库对象
     * 2. 需要执行的sql语句，C语言字符串
     * 3. 执行sql语句之后的回调，一般可以传nil
     * 4. 是第三个参数：回调函数 的参数，一般可以传nil
     * 5. 错误信息，一般可以传nil
     */
    if ( sqlite3_exec(self.db, cSql, nil, nil, nil) != SQLITE_OK ) {
        return NO;
    }
    else{
        return YES;
    }
}

/**
 * @func   执行查询SQL语句
 * @return 查询到的字典数组
 */
- (NSArray<NSDictionary *> *)execQuerySQL:(NSString *)sql{
    const char *cSql= [sql cStringUsingEncoding:NSUTF8StringEncoding];
    //1. 准备数据
    /* @param
     * 1. 已经打开的数据库对象
     * 2. 需要执行的sql语句，C语言字符串
     * 3. 执行sql语句的长度：传入-1系统自动计算
     * 4. ppStmt: 预编译之后的一个句柄，以后要想取出数据，就需要这个句柄
     * 5. 一般可以传nil
     */
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(self.db, cSql, -1, &stmt, nil) != SQLITE_OK){
        NSLog(@"准备失败");
    };
    NSMutableArray *recordsArr = [NSMutableArray array];
    //2. 查询数据
    //sqlite3_step代表去除一条数据，如果取到了数据，就会返回 SQLITE_ROW
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        [recordsArr addObject:[self itemOfRecords:stmt]];
    }
    return recordsArr;
}

- (NSDictionary *)itemOfRecords:(sqlite3_stmt *)stmt{
    //2.1 拿到当前这条数据所有的列
    NSUInteger count = sqlite3_column_count(stmt);
    
    //2.2 拿到每一列的名称
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionary];
    for (int index=0; index<count; index++){
        const char *cName = sqlite3_column_name(stmt, index);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"key: %@",name);
        
        //在这里拿到数据字段的类型，然后通过类型去
        /*
         * SQLITE_INTEGER  1
         * SQLITE_FLOAT    2
         * SQLITE3_TEXT    3
         * SQLITE_BLOB     4
         * SQLITE_NULL     5
         */
        NSInteger type = sqlite3_column_type(stmt, index);
        
        switch (type) {
            case SQLITE_INTEGER:{//整型
                NSInteger num = sqlite3_column_int64(stmt, index);
                recordDic[name] = @(num);
                NSLog(@"value: %ld",num);
                break;
            }
            case SQLITE_FLOAT:{//浮点型
                double floatNum= sqlite3_column_double(stmt, index);
                recordDic[name] = @(floatNum);
                NSLog(@"value: %f",floatNum);
                break;
            }
            case SQLITE3_TEXT:{//文本类型
                const char *cText = (const char *)sqlite3_column_text(stmt, index);
                NSString *text = [NSString stringWithCString:cText encoding:NSUTF8StringEncoding];
                recordDic[name] = text;
                NSLog(@"value: %@",text);
                break;
            }
            case SQLITE_NULL://空类型
                recordDic[name] = [NSNull null];
                break;
            default://二进制类型
                break;
        }
    }
    return recordDic;
}

@end

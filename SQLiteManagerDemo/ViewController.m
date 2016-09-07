//
//  ViewController.m
//  SQLite基本使用
//
//  Created by shoule on 16/9/6.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

#import "ViewController.h"
#import "SQLiteManager.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, strong) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc]init];
    self.person.name = @"rose";
    self.person.age = 19;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[SQLiteManager sharedSQLiteManager] createTable:NSStringFromClass([Person class])];

    NSArray *models = [Person loadPersons];
    NSLog(@"");
}

- (IBAction)insert:(id)sender {
    if ([self.person updatePerson]){
        NSLog(@"SQL执行成功");
    }
    else{
        NSLog(@"SQL执行失败");
    }
}

- (IBAction)delete:(id)sender {
    if ([self.person updatePerson]){
        NSLog(@"SQL执行成功");
    }
    else{
        NSLog(@"SQL执行失败");
    }
}

- (IBAction)update:(id)sender {
    if ([self.person updatePerson]){
        NSLog(@"SQL执行成功");
    }
    else{
        NSLog(@"SQL执行失败");
    }
}

- (IBAction)select:(id)sender {
    if ([self.person updatePerson]){
        NSLog(@"SQL执行成功");
    }
    else{
        NSLog(@"SQL执行失败");
    }
}



@end

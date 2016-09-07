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
    [[SQLiteManager sharedSQLiteManager] createTable:NSStringFromClass([Person class])];
    self.person = [[Person alloc]init];
    self.person.name = @"rose";
    self.person.age = 19;
}


- (IBAction)insert:(id)sender {
    [self Decribe:[self.person updatePerson]];
}

- (IBAction)delete:(id)sender {
    [self Decribe:[self.person deletePerson]];
}

- (IBAction)update:(id)sender {
    [self Decribe:[self.person updatePerson]];
}

- (IBAction)select:(id)sender {
    NSArray *models = [Person loadPersons];
    [self Decribe:([Person loadPersons] != nil)];
}

- (void)Decribe:(BOOL)success{
    if (success) NSLog(@"SQL执行成功");
    else NSLog(@"SQL执行失败");
}

@end

//
//  ViewController.m
//  sqliteDemo
//
//  Created by shijiangwang on 12-11-2.
//  Copyright (c) 2012年 shijiangwang. All rights reserved.
//

#import "ViewController.h"

#define DBNAME @"personinfo.sqlite"
#define NAME @"name"
#define AGE @"age"
#define ADDRESS @"address"
#define TABLENAME @"PERSONINFO"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
//
//    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS PERSONINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, address TEXT)";
//    [self execSql:sqlCreateTable];
    
//    NSString *sql1 = [NSString stringWithFormat:
//                      @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
//                      TABLENAME, NAME, AGE, ADDRESS, @"张三", @"23", @"西城区"];
//    
//    NSString *sql2 = [NSString stringWithFormat:
//                      @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
//                      TABLENAME, NAME, AGE, ADDRESS, @"老六", @"20", @"东城区"];
//    [self execSql:sql1];
//    [self execSql:sql2];
    //
    NSString *sqlQuery = [@"SELECT * FROM " stringByAppendingString:TABLENAME];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char *) sqlite3_column_text(statement, 1);
            NSString *nsNameStr = [[NSString alloc] initWithUTF8String:name];
            int age = sqlite3_column_int(statement, 2);
            char *adress = (char *) sqlite3_column_text(statement, 3);
            NSString *nsAddressStr = [[NSString alloc] initWithUTF8String:adress];
            NSLog(@"name:%@ age:%d address:%@", nsNameStr, age, nsAddressStr);
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)execSql:(NSString *) sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作失败！");
    }
}

@end

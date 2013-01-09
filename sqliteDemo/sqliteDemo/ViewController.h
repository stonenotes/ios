//
//  ViewController.h
//  sqliteDemo
//
//  Created by shijiangwang on 12-11-2.
//  Copyright (c) 2012年 shijiangwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface ViewController : UIViewController
{
    sqlite3 *db;
}
@end

//
//  DBFileManager.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/20.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "DBFileManager.h"
#import "common.h"

@interface DBFileManager ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation DBFileManager

+ (instancetype)shareHandle
{
    static DBFileManager *handle;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        handle = [[DBFileManager alloc] init];
        [handle createTable];
    });
    return handle;
}

- (FMDatabase *)db
{
    if (_db) {
        return _db;
    }
    
    //合并文件路径
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kDBName];
    NSLog(@"dbPath ------------------------------------%@",dbPath);
    //创建数据库对象
    _db = [FMDatabase databaseWithPath:dbPath];
    return _db;
}

- (BOOL)createTable
{
    //1.打开数据库
    if (![self.db open]) {
        NSLog(@"<%s> >>> 打开数据库失败",__FUNCTION__);
        return NO;
    }
    
    //2.执行sql
    if (![self.db executeUpdate:@"create table if not exists news (title text, image text, url text)"]) {
        [self.db close];
        return NO;
    }
    
    //3.关闭数据库
    [self.db close];
    
    return YES;
    
}

- (BOOL)insertIntoData:(TheMainModel *)model
{
    //1.打开数据库
    if (![self.db open]) {
        NSLog(@"<%s> >>> 打开数据库失败",__FUNCTION__);
        return NO;
    }
    //2.执行sql
    if (![self.db executeUpdateWithFormat:@"insert into news values (%@,%@,%@)",model.title,model.thumbnail,model.share]) {
        NSLog(@"insert error >>> %@",[self.db lastErrorMessage]);
        [self.db close];
        return NO;
    }

    //3.关闭数据库
    [self.db close];
    
    return YES;
}

- (BOOL)deleteDataFromUrl:(NSString *)url
{
    //1.打开数据库
    if (![self.db open]) {
        NSLog(@"<%s> >>> 打开数据库失败",__FUNCTION__);
        return NO;
    }
    //2.执行sql
    if (![self.db executeUpdate:@"delete from news where url = ? ",url]) {
        NSLog(@"delete error >>> %@",[self.db lastErrorMessage]);
        [self.db close];
        return NO;
    }
    
    //3.关闭数据库
    [self.db close];
    
    return YES;
}

- (TheMainModel *)modelFromSetValue:(FMResultSet *)set
{
    NSString *title = [set stringForColumn:@"title"];
    NSString *image = [set stringForColumn:@"image"];
    NSString *url = [set stringForColumn:@"url"];
    
    return [TheMainModel initWithTitle:title withImage:image withUrl:url];
}

- (NSMutableArray *)selectAllValue
{
    //1.打开数据库
    if (![self.db open]) {
        NSLog(@"<%s> >>> 打开数据库失败",__FUNCTION__);
        return NO;
    }
    //2.执行sql
    FMResultSet *set = [self.db executeQuery:@"select * from news"];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        [array addObject:[self modelFromSetValue:set]];
    }
    
    //3.关闭数据库
    [self.db close];
    
    return array;
}

@end

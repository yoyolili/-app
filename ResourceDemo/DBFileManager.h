//
//  DBFileManager.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/20.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TheMainModel;

@interface DBFileManager : NSObject

+ (instancetype)shareHandle;

//插入数据
- (BOOL)insertIntoData:(TheMainModel *)model;

//查询所有数据
- (NSMutableArray *)selectAllValue;

//删除数据
- (BOOL)deleteDataFromUrl:(NSString *)url;

@end

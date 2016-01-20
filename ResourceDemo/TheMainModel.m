//
//  TheMainModel.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/11.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheMainModel.h"

@implementation TheMainModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

+ (instancetype)initWithTitle:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)url
{
    TheMainModel *model = [[TheMainModel alloc] init];
    model.title = title;
    model.thumbnail = image;
    model.share = url;
    
    return model;
}

@end

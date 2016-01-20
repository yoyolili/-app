//
//  TheMainModel.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/11.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheMainModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *share;
@property (nonatomic, strong) NSString *thumbnail;

@property (nonatomic) BOOL isSave;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)initWithTitle:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)url;

@end

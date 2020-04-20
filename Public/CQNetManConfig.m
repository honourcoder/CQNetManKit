//
//  CQNetManConfig.m
//  CQNetManKit
//
//  Created by Arthur on 2020/4/20.
//

#import "CQNetManConfig.h"

static CQNetManConfig * _instance;

@interface CQNetManConfig ()<NSCopying,NSMutableCopying>

@end

@implementation CQNetManConfig


+(instancetype)sharedInstance{
     return [[self alloc]init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    //在alloc的总接口限制创建的操作
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//限制Copy操作创建的对象
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return _instance;
}
//限制MutableCopy操作创建的对象
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return _instance;
}


@end

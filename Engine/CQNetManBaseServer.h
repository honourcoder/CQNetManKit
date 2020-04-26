//
//  NetManBaseServer.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQNetManDefine.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  这里是
 */
typedef NS_ENUM(NSUInteger,CQEnvironmentType) {
    CQEnvironmentTypeDevelop,
    CQEnvironmentTypePreRelease,
    CQEnvironmentTypeRelease,
};


@interface CQNetManBaseServer : NSObject

//服务器类型
@property (nonatomic, assign) CQEnvironmentType environmentType;

///测试地址1
@property (nonatomic, strong) NSString *apiBaseUrlForTest1;
///测试地址2
@property (nonatomic, strong) NSString *apiBaseUrlForTest2;
///测试地址3
@property (nonatomic, strong) NSString *apiBaseUrlForTest3;
///开发地址
@property (nonatomic, strong) NSString *apiBaseUrlForDevelope;
///预上线地址
@property (nonatomic, strong) NSString *apiBaseUrlForPrerelease;
///生产地址
@property (nonatomic, strong) NSString *apiBaseUrlForRelease;

///不要重写这个的get方法
@property (nonatomic, strong, readonly) NSString *apiBaseUrl;

@end

NS_ASSUME_NONNULL_END

//
//  NetManBaseServer.m
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "CQNetManBaseServer.h"

@interface CQNetManBaseServer ()

//@property (nonatomic, weak) NetManBaseServer *child;
@property (nonatomic, strong) NSString *customApiBaseUrl;

@end

@implementation CQNetManBaseServer

@synthesize apiBaseUrl = _apiBaseUrl;

- (instancetype)init
{
    self = [super init];
    if (self) {        //默认设置开发环境
        self.environmentType = CQEnvironmentTypeDevelop;
    }
    return self;
}



- (NSString *)apiBaseUrl
{
    if (_apiBaseUrl == nil) {
        switch (self.environmentType) {
            case CQEnvironmentTypeDevelop:
                _apiBaseUrl = self.apiBaseUrlForDevelope;
                break;
            case CQEnvironmentTypePreRelease:
                _apiBaseUrl = self.apiBaseUrlForPrerelease;
                break;
            case CQEnvironmentTypeRelease:
                _apiBaseUrl = self.apiBaseUrlForRelease;
                break;
            default:
                break;
        }
    }
    return _apiBaseUrl;
}

@synthesize apiBaseUrlForDevelope = _apiBaseUrlForDevelope;

@synthesize apiBaseUrlForPrerelease = _apiBaseUrlForPrerelease;

@synthesize apiBaseUrlForRelease = _apiBaseUrlForRelease;

@end

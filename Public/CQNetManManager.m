//
//  NetManManger.m
//  CQNetFrame
//
//  Created by CoderQi on 2019/8/15.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "CQNetManManager.h"
#import "CQNetManBaseRequestModel.h"
#import "CQNetManRequestGenerator.h"
#import "CQNetManWorkHandler.h"
#import "CQNetManHandler.h"

@interface CQNetManManager ()

//AFNetworking stuff
//@property (nonatomic, strong) AFURLSessionManager *sessionManager;
// 根据 requestid，存放 task
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;
// 根据 requestID，存放 requestModel
@property (nonatomic, strong) NSMutableDictionary *requestModelDict;

@end

@implementation CQNetManManager

+(instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    static CQNetManManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CQNetManManager alloc] init];
    });
    return sharedInstance;
}

/**
 *  取消网络请求
 */
-(void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *task = [self.dispatchTable objectForKey:requestID];
    [task cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

/**
 *  根据dataModel发起网络请求，并根据dataModel发起回调
 *
 *
 *  @return 网络请求task哈希值
 */
- (NSNumber *)callRequestWithRequestModel:(CQNetManBaseRequestModel *)requestModel{
    NSURLRequest *request = [[CQNetManRequestGenerator defaultGenerator] generateWithRequestDataModel:requestModel];
    NSURLSessionTask *task = [CQNetManWorkHandler doNetWorkWithRequst:request andSolveBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    NSNumber *requestID = [NSNumber numberWithUnsignedInteger:task.hash];
    [self.dispatchTable setObject:task forKey:requestID];
    return requestID;
}


-(void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList
{
    typeof(self) __weak weakSelf = self;
    [requestIDList enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURLSessionDataTask *task = [weakSelf.dispatchTable objectForKey:obj];
        [task cancel];
    }];
    [self.dispatchTable removeObjectsForKeys:requestIDList];
}

- (NSMutableDictionary *)dispatchTable{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}


@end

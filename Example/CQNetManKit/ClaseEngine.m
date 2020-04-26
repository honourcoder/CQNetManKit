//
//  ClaseEngine.m
//  CQNetManKit_Example
//
//  Created by Arthur on 2020/4/26.
//  Copyright © 2020 honourcoder. All rights reserved.
//

#import "ClaseEngine.h"
#import "ClassServer.h"

@interface ClaseEngine ()

@property(nonatomic, copy)ClassServer *server;

@end

@implementation ClaseEngine

-(instancetype)init{
    self = [super init];
    if(self){
        self.server = [[ClassServer alloc] init];
        self.server.environmentType = CQEnvironmentTypeDevelop;
    }
    return self;
}

-(void)doGetUserInfoByUserID:(NSString *)uerId WithSolveBlock:(CQCompletionHandlerBlock)block{
//    [CQNetManEngine requestWithServer:self.server APIUrlPath:@"/path" param:@[] requestType:CQNetManRequestTypePost lifeRelativeTo:self progressBlock:nil completeBlock:^(id data, NSError *error){
//        block(data, error);
//    }];
}

@end

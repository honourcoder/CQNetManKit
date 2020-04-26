//
//  NetManRequestGenerator.m
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "CQNetManRequestGenerator.h"
#import "CQNetManGenerator.h"
#import "NSString+NetMan.h"
#import "CQNetManBaseRequestModel.h"
#import "CQNetManBaseServer.h"
#import "CQNetManHttpRequestSerializer.h"

static NSTimeInterval kNetManTimeoutSeconds = 20.0f;

@interface CQNetManRequestGenerator ()

@property (nonatomic, strong)CQNetManHttpRequestSerializer *httpRequestSerializer;

@end

@implementation CQNetManRequestGenerator

/**
 *  生成一个单例
 */
+ (instancetype)defaultGenerator{
    static dispatch_once_t onceToken;
    static CQNetManRequestGenerator *generator = nil;
    dispatch_once(&onceToken, ^{
        generator = [[CQNetManRequestGenerator alloc] init];
    });
    return generator;
}


- (NSURLRequest *)generateWithRequestDataModel:(CQNetManBaseRequestModel *)dataModel
{
    //这里用多肽，动态获取
    CQNetManBaseServer *server;
    if(dataModel.netManServerDelegate){
        server = dataModel.netManServerDelegate;
    }else{
        server = [[CQNetManBaseServer alloc] init];
    }
    BOOL baseUrlIsError = NO;
    if(![self isCorrectPreUrl:dataModel.netManServerDelegate.apiBaseUrlForDevelope]){
        baseUrlIsError = YES;
    }
    if(![self isCorrectPreUrl:dataModel.netManServerDelegate.apiBaseUrlForPrerelease]){
        baseUrlIsError = YES;
    }
    if(![self isCorrectPreUrl:dataModel.netManServerDelegate.apiBaseUrlForRelease]){
        baseUrlIsError = YES;
    }
    if(![self isCorrectPreUrl:dataModel.netManServerDelegate.apiBaseUrlForTest1]){
        baseUrlIsError = YES;
    }
    if(![self isCorrectPreUrl:dataModel.netManServerDelegate.apiBaseUrlForTest2]){
        baseUrlIsError = YES;
    }
    if(![self isCorrectPreUrl:dataModel.netManServerDelegate.apiBaseUrlForTest3]){
        baseUrlIsError = YES;
    }
    if(baseUrlIsError){
        NSAssert(NO,@"BaseServer子类的BaseUrl存在不合法数值");
    }
    
    server.environmentType = (CQEnvironmentType)dataModel.serverType;
    NSMutableDictionary *commonParams = [NSMutableDictionary dictionaryWithDictionary:[CQNetManGenerator generateCommonInfoParamsDictionary]];
    [commonParams addEntriesFromDictionary:dataModel.parameters];
    
    NSString *urlString = [self URLStringWithServiceUrl:server.apiBaseUrl path:dataModel.apiMethodPath];
    NSError *error;
    NSMutableURLRequest *request;
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    if (dataModel.requestType == CQNetManRequestTypeGet) {
        #pragma mark 等待替换
        request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:commonParams error:&error];
    } else if (dataModel.requestType == CQNetManRequestTypePost) {
        request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:commonParams error:&error];
    } else if (dataModel.requestType == CQNetManRequestTypeUpload) {
//        request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:commonParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            /**
//             *  这里的参数配置也可以根据自己的设计修改默认值.
//             为什么没有直接使用NSData?
//             */
//            if (![NSString isEmptyString:dataModel.dataFileURLPath]) {
//                NSURL *fileURL = [NSURL fileURLWithPath:dataModel.dataFileURLPath];
//                NSString *name = dataModel.dataName?dataModel.dataName:@"data";
//                NSString *fileName = dataModel.fileName?dataModel.fileName:@"data.zip";
//                NSString *mimeType = dataModel.mimeType?dataModel.mimeType:@"application/zip";
//                NSError *error;
//                [formData appendPartWithFileURL:fileURL
//                                           name:name
//                                       fileName:fileName
//                                       mimeType:mimeType
//                                          error:&error];
//            }
//
//        } error:&error];
    }
    if (error || request == nil) {
        return nil;
    }
    
    request.timeoutInterval = kNetManTimeoutSeconds;
    return request;
}
#pragma mark - private methods
- (NSString *)URLStringWithServiceUrl:(NSString *)serviceUrl path:(NSString *)path{
    NSURL *fullURL = [NSURL URLWithString:serviceUrl];
    if (![NSString isEmptyString:path]) {
        fullURL = [NSURL URLWithString:path relativeToURL:fullURL];
    }
    if (fullURL == nil) {
        return nil;
    }
    return [fullURL absoluteString];
}

-(BOOL)isCorrectPreUrl:(NSString *)string{
    NSString *pattern = @"^([hH][tT]{2}[pP]://|[hH][tT]{2}[pP][sS]://)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\\/])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}


-(CQNetManHttpRequestSerializer *)httpRequestSerializer{
    if(!_httpRequestSerializer){
        _httpRequestSerializer = [[CQNetManHttpRequestSerializer alloc] init];
    }
    return _httpRequestSerializer;
}
@end

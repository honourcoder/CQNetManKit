//
//  CQNetManHandler.m
//  CQNetManKit
//
//  Created by Arthur's on 2020/4/16.
//

#import "CQNetManHandler.h"

@implementation CQNetManHandler

+(void)doGetWithURL:(NSString *)urlString andSloveBlock:(CQNetManResponseSolveBlock)handlerBlock{
    NSString *urlStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlStr];
        
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    
    [self doNetWorkWithRequst:request andSolveBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        handlerBlock(data, response, error);
    }];
}

+(void)doPostWithURL:(NSString *)urlString andParams:(NSDictionary *)params andSloveBlock:(CQNetManResponseSolveBlock)handlerBlock{
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    [self doPostWithURL:urlString andParamsData:bodyData andSloveBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        handlerBlock(data, response, error);
    }];
}

+(void)doPostWithURL:(NSString *)urlString andParamsData:(NSData *)paramsData andSloveBlock:(CQNetManResponseSolveBlock)handlerBlock{
    NSString *urlStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlStr];
        
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:paramsData];
    
    [self doNetWorkWithRequst:request andSolveBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        handlerBlock(data, response, error);
    }];
}

+(void)doNetWorkWithRequst:(NSURLRequest *)request andSolveBlock:(CQNetManResponseSolveBlock)handlerBlock{
    NSURLSession *sharedSession = [NSURLSession sharedSession];
        
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        handlerBlock(data, response, error);
    
    }];
    [dataTask resume];
}

@end

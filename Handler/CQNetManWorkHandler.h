//
//  CQNetManWorkHandler.h
//  CQNetManKit
//
//  Created by Arthur on 2020/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CQNetManResponseSolveBlock)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface CQNetManWorkHandler : NSObject


+(void)doGetWithURL:(NSString *)urlString andSloveBlock:(CQNetManResponseSolveBlock)handlerBlock;

+(void)doPostWithURL:(NSString *)urlString andParams:(NSDictionary *)params andSloveBlock:(CQNetManResponseSolveBlock)handlerBlock;

+(void)doPostWithURL:(NSString *)urlString andParamsData:(NSData *)paramsData andSloveBlock:(CQNetManResponseSolveBlock)handlerBlock;

+(NSURLSessionTask *)doNetWorkWithRequst:(NSURLRequest *)request andSolveBlock:(CQNetManResponseSolveBlock)handlerBlock;

@end

NS_ASSUME_NONNULL_END

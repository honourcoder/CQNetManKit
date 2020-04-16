//
//  CQNetManHandler.h
//  CQNetManKit
//
//  Created by Arthur's on 2020/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CQNetManResponseSolveBlock)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface CQNetManHandler : NSObject


+(void)doGetWithURL:(NSString *)urlString andSloveBlock:(CQNetManResponseSolveBlock)handlerBlock;

+(void)doPostWithURL:(NSString *)urlString andParams:(NSDictionary *)params andSloveBlock:(CQNetManResponseSolveBlock)handlerBlock;

+(void)doPostWithURL:(NSString *)urlString andParamsData:(NSData *)paramsData andSloveBlock:(CQNetManResponseSolveBlock)handlerBlock;


@end

NS_ASSUME_NONNULL_END

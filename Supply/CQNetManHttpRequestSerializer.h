//
//  CQNetManHttpRequestSerializer.h
//  CQNetManKit
//
//  Created by Arthur on 2020/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQNetManHttpRequestSerializer : NSObject

/**
 * Request生成器
 */
-(void)requestWithMethod:(NSString *)methodType URLString:(NSString *)urlString parameters:(NSDictionary *)params error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END

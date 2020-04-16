//
//  NetManGenerator.h
//  CQNetManKit
//
//  Created by Arthur on 2020/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
*
* NetMan生成器，负责生成一些固定的产物，如 请求参数的MD5、生成应用基本信息
*
*/
@interface CQNetManGenerator : NSObject

+ (NSString *)generateParamsSignature:(NSDictionary *)paramsDict;


+ (NSString *)generateParamsSignature:(NSDictionary *)paramsDict publicKey:(NSString *)publicKey;

+(NSDictionary *)generateCommonInfoParamsDictionary;


@end

NS_ASSUME_NONNULL_END

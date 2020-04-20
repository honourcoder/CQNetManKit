//
//  CQNetManConfig.h
//  CQNetManKit
//
//  Created by Arthur on 2020/4/20.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CQNetManCachePolicy) {
    CQNetManCachePolicyCacheAppoint,//只缓存指定的那些请求
    CQNetManCachePolicyNoCache,//所有都不进行缓存
    CQNetManCachePolicyCacheAll,//所有的都进行缓存
};

NS_ASSUME_NONNULL_BEGIN

@interface CQNetManConfig : NSObject

/**
 * 是否支持https单向请求
 */
@property (nonatomic, assign) BOOL isSupprlyHttps;

/**
 * 缓存文件的最大体积
 */
@property (nonatomic, assign) NSInteger cacheMaxSize;

/**
 * 缓存请求的最大个数
 */
@property (nonatomic, assign) NSInteger cacheMaxCount;

/**
 * 缓存策略,默认只缓存指定的请求
 */
@property (nonatomic, assign)CQNetManCachePolicy cachePolicy;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END

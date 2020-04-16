//
//  CQNetManBaseRequestModel.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/7/11.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQNetManConfig.h"
#import "CQNetManBaseServer.h"

NS_ASSUME_NONNULL_BEGIN

@class CQNetManBaseServer;

@interface CQNetManBaseRequestModel : NSObject


//请求相关部分
/**  网络请求地址  **/
@property (nonatomic, strong) NSString *apiMethodPath;
/**  服务器类型  */
@property (nonatomic, assign) CQNetManServerType serverType;
/**  请求参数  **/
@property (nonatomic, strong) NSDictionary *parameters;
/**  网络请求方式  **/
@property (nonatomic, assign) CQNetManRequestType requestType;



//上传下载部分
/**  文件路径  **/
@property (nonatomic, strong) NSString *dataFileURLPath;
/**  上传文件名字  **/
@property (nonatomic, strong) NSString *dataName;
/**  上传参数名字  **/
@property (nonatomic, strong) NSString *fileName;
/**  上传文件类型名字  **/
@property (nonatomic, strong) NSString *mimeType;


/**  上传进度回调  **/
@property (nonatomic, copy) ProgressBlock uploadProgressBlock;
/**  下载进度回调  **/
@property (nonatomic, copy) ProgressBlock downloadProgressBlock;

@property (nonatomic, assign) CQNetManBaseServer *netManServerDelegate;
/**  请求着陆回调  **/
@property (nonatomic, copy) CompletionHandlerBlock responseBlock;

/** 自定义便利构造器 */
+(CQNetManBaseRequestModel *)dataModelWithServerType:(CQNetManServerType)serverType
                                         APIUrlPath:(NSString *)apiUrl
                                              param:(NSDictionary *)parameters
                                       dataFilePath:(NSString *)dataFilePath
                                           dataName:(NSString *)dataName
                                           fileName:(NSString *)fileName
                                           mimeType:(NSString *)mimeType
                                        requestType:(CQNetManRequestType)requestType
                                uploadProgressBlock:(ProgressBlock)uploadProgressBlock
                              downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                                           complete:(CompletionHandlerBlock)responseBlock;

@end

NS_ASSUME_NONNULL_END

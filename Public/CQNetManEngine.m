//
//  CQBaseNetEngine.m
//  CQNetFrame
//
//  Created by Arthur's on 2019/7/11.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "CQNetManEngine.h"
#import "CQNetManManager.h"
#import "CQNetManBaseRequestModel.h"
#import "NSObject+NMNetWorkingAutoCancel.h"
#import "CQNetManBaseServer.h"

@interface CQNetManEngine ()

/**  请求的ID编号  **/
@property (nonatomic, strong) NSNumber *requestID;

/**  请求的ID编号数组  **/
@property (nonatomic, strong) NSMutableArray *requestIDArray;

@end

@implementation CQNetManEngine

-(void)dealloc
{
    [self cancelAllRequest];
}

/**
 *  取消self持有的hash的网络请求
 */
-(void)cancelRequest
{
    [[CQNetManManager defaultManager] cancelRequestWithRequestID:self.requestID];
}

-(void)cancelAllRequest
{
    [[CQNetManManager defaultManager] cancelRequestWithRequestIDList:self.requestIDArray];
}



/**
* 请求服务器数据响应函数，这里可以对每种请求方式分别提取一个方法，方便上层Engine调用
*
* @param server          服务器相关信息
* @param apiUrl          API路径
* @param parameters      参数字典
* @param requestType     网络请求类型
* @param lifeObject      生命周期关联对象
* @param progressBlock   网络进度回调
* @param handlerBlock    请求结果数据处理回调
**/
-(CQNetManEngine *)requestWithServer:(CQNetManBaseServer *)server
                                 APIUrlPath:(NSString *)apiUrl
                                      param:(NSDictionary *)parameters
                                requestType:(CQNetManRequestType)requestType
                             lifeRelativeTo:(NSObject *)lifeObject
                              progressBlock:(CQProgressBlock)progressBlock
                              completeBlock:(CQCompletionHandlerBlock)handlerBlock
{
    
    CQNetManEngine *engine = [[CQNetManEngine alloc]init];
    __weak typeof(lifeObject) weakControl = lifeObject;
    CQNetManBaseRequestModel *dataModel = [CQNetManBaseRequestModel dataModelWithServerType:(CQNetManServerType)server.environmentType APIUrlPath:apiUrl param:parameters dataFilePath:nil dataName:nil fileName:nil mimeType:nil requestType:requestType uploadProgressBlock:progressBlock downloadProgressBlock:nil complete:^(id data, NSError *error) {
        if (handlerBlock) {
            //可以在这里做错误的UI处理，或者是在上层engine做
            handlerBlock(data,error);
        }
        [weakControl.netManAutoCancelRequests removeEngineWithRequestID:engine.requestID];
    }];
    dataModel.netManServerDelegate = server;
    [engine callRequestWithRequestModel:dataModel control:lifeObject];
    return engine;
}

/**
 * 将文件上传到服务器，这里可以对每种请求方式分别提取一个方法，方便上层Engine调用
 *
 * @param control                控制器对象
 * @param serverType             服务器类型
 * @param apiUrl                 API路径
 * @param parameters             参数字典
 * @param dataFilePath           上传文件路径
 * @param dataName               文件名字
 * @param fileName               服务器接收名字
 * @param mimeType               文件类型
 * @param requestType            网络请求类型
 * @param uploadProgressBlock    上传进度回调
 * @param responseBlock          请求结果数据处理回调
 **/
- (CQNetManEngine *) control:(NSObject *)control
    uploadRequestWithServerType:(CQNetManServerType)serverType
                     serverInfo:(CQNetManBaseServer *)server
                     APIUrlPath:(NSString *)apiUrl
                          param:(NSDictionary *)parameters
                   dataFilePath:(NSString *)dataFilePath
                       dataName:(NSString *)dataName
                       fileName:(NSString *)fileName
                       mimeType:(NSString *)mimeType
                    requestType:(CQNetManRequestType)requestType
            uploadProgressBlock:(CQProgressBlock)uploadProgressBlock
          downloadProgressBlock:(CQProgressBlock)downloadProgressBlock
                  completeBlock:(CQCompletionHandlerBlock)responseBlock
{
    CQNetManEngine *engine = [[CQNetManEngine alloc]init];
    __weak typeof(control) weakControl = control;
    CQNetManBaseRequestModel *dataModel = [CQNetManBaseRequestModel dataModelWithServerType:serverType APIUrlPath:apiUrl param:parameters dataFilePath:dataFilePath dataName:dataName fileName:fileName mimeType:mimeType requestType:requestType uploadProgressBlock:uploadProgressBlock downloadProgressBlock:downloadProgressBlock complete:^(id data, NSError *error) {
        if (responseBlock) {
            //可以在这里做错误的UI处理，或者是在上层engine做
            responseBlock(data,error);
        }
        [weakControl.netManAutoCancelRequests removeEngineWithRequestID:engine.requestID];
    }];
    [engine callRequestWithRequestModel:dataModel control:control];
    return engine;
}


/**
 * 从服务器下载文件，这里可以对每种请求方式分别提取一个方法，方便上层Engine调用
 *
 * @param control                控制器对象
 * @param serverType             服务器类型
 * @param apiUrl                 API路径
 * @param parameters             参数字典
 * @param requestType            网络请求类型
 * @param downloadProgressBlock  下载进度回调
 * @param responseBlock          请求结果数据处理回调
 **/

- (CQNetManEngine *) control:(NSObject *)control
  downloadRequestWithServerType:(CQNetManServerType)serverType
                     serverInfo:(CQNetManBaseServer *)server
                     APIUrlPath:(NSString *)apiUrl
                          param:(NSDictionary *)parameters
                    requestType:(CQNetManRequestType)requestType
          downloadProgressBlock:(CQProgressBlock)downloadProgressBlock
                  completeBlock:(CQCompletionHandlerBlock)responseBlock
{
    CQNetManEngine *engine = [[CQNetManEngine alloc]init];
    __weak typeof(control) weakControl = control;
    CQNetManBaseRequestModel *dataModel = [CQNetManBaseRequestModel dataModelWithServerType:serverType APIUrlPath:apiUrl param:parameters dataFilePath:nil dataName:nil fileName:nil mimeType:nil requestType:requestType uploadProgressBlock:nil downloadProgressBlock:downloadProgressBlock complete:^(id data, NSError *error) {
        if (responseBlock) {
            //可以在这里做错误的UI处理，或者是在上层engine做
            responseBlock(data,error);
        }
        [weakControl.netManAutoCancelRequests removeEngineWithRequestID:engine.requestID];
    }];
    [engine callRequestWithRequestModel:dataModel control:control];
    return engine;
}


- (void) callRequestWithRequestModel:(CQNetManBaseRequestModel *)dataModel control:(NSObject *)control{
    self.requestID = [[CQNetManManager defaultManager] callRequestWithRequestModel:dataModel];
    [control.netManAutoCancelRequests setEngine:self requestID:self.requestID];
}

@end

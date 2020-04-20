//
//  NetManConfig.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/7/11.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#ifndef CQNetManDefine_h
#define CQNetManDefine_h

typedef NS_ENUM(NSUInteger, CQNetManServerType) {
    CQNetManServerTypeDevelop,                  //测试服务器
    CQNetManServerTypePrepareRelease,         //发版前服务器
    CQNetManServerTypeRelease,                //正式服务器
    
};

//网络请求类型
typedef NS_ENUM(NSInteger, CQNetManRequestType){
    CQNetManRequestTypeGet,       //get请求
    CQNetManRequestTypePost,      //post请求
    CQNetManRequestTypeUpload,    //上传文件
    CQNetManRequestTypeDownload   //下载文件
};

typedef void(^ProgressBlock)(NSProgress *taskProgress);
typedef void(^CompletionHandlerBlock)(id data, NSError *error);

#endif /* CQNetManDefine_h */

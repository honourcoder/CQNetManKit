//
//  CQNetManHttpRequestSerializer.m
//  CQNetManKit
//
//  Created by Arthur on 2020/4/20.
//

#import "CQNetManHttpRequestSerializer.h"
#import "CQNetManErrorHandler.h"

@implementation CQNetManHttpRequestSerializer

-(NSMutableURLRequest *)requestWithMethod:(NSString *)methodType URLString:(NSString *)urlString parameters:(NSDictionary *)params error:(NSError **)error{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //检查URL是否存在问题
    if(![self isCorrectPreUrl:urlString]){
        *error = [CQNetManErrorHandler ErrorWithErrorCode:CQNetManErrorCodeURLError WithDescString:[NSString stringWithFormat:@"URL地址不正确:[%@]存在错误", urlString]];
        return nil;
    }
    //检查MethodType是否能正确转化成对应的方法
    methodType = [methodType uppercaseString];
    if([methodType isEqualToString:@"POST"]){
        //设置Post请求方式
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        
        NSError *er = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&er];
        if(er){
            *error = [CQNetManErrorHandler ErrorWithErrorCode:CQNetManErrorCodeFormatError WithDescString:[NSString stringWithFormat:@"类型转换:[%@]的json格式存在错误", params]];
        }else{
            [request setHTTPBody:data];
        }
        
    }else if([methodType isEqualToString:@"GET"]){
        //设置Get请求方式
        //这里不需要设置
    }else{
        //没有指定的方法，这里不需要进行设置
        *error = [CQNetManErrorHandler ErrorWithErrorCode:CQNetManErrorCodeParamError WithDescString:[NSString stringWithFormat:@"请求方法类型:[%@]存在错误", urlString]];
        return nil;
    }
    return request;
}


-(BOOL)isCorrectPreUrl:(NSString *)string{
    NSString *pattern = @"^([hH][tT]{2}[pP]://|[hH][tT]{2}[pP][sS]://)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\\/])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

@end

//
//  CQNetManHttpRequestSerializer.m
//  CQNetManKit
//
//  Created by Arthur on 2020/4/20.
//

#import "CQNetManHttpRequestSerializer.h"

@implementation CQNetManHttpRequestSerializer

-(NSMutableURLRequest *)requestWithMethod:(NSString *)methodType URLString:(NSString *)urlString parameters:(NSDictionary *)params error:(NSError **)error{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //检查URL是否存在问题
    if(![self isCorrectPreUrl:urlString]){
        *error = [[NSError alloc] initWithDomain:@"[CQNetManKit]" code:20401 userInfo:@{@"userInfo" : [NSString stringWithFormat:@"URL地址不正确:[%@]存在错误", urlString]}];
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
            *error = [[NSError alloc] initWithDomain:@"[CQNetManKit]" code:20302  userInfo:@{@"userInfo" : [NSString stringWithFormat:@"Json Format Error:[%@]存在错误", [params description] ]}];
        }else{
            [request setHTTPBody:data];
        }
        
    }else if([methodType isEqualToString:@"GET"]){
        //设置Get请求方式
        //这里不需要设置
    }else{
        //没有指定的方法，这里不需要进行设置
        *error = [[NSError alloc] initWithDomain:@"[CQNetManKit]" code:20301 userInfo:@{@"userInfo" : [NSString stringWithFormat:@"Method Type Error:[%@]存在错误", methodType]}];
        return nil;
    }
    
    //检查生成过程是否存在问题
    return request;
}


-(BOOL)isCorrectPreUrl:(NSString *)string{
    NSString *pattern = @"^([hH][tT]{2}[pP]://|[hH][tT]{2}[pP][sS]://)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\\/])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

@end

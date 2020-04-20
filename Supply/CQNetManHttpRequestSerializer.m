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
    //检查参数是否标准
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

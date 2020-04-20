//
//  CQNetManHttpRequestSerializer.m
//  CQNetManKit
//
//  Created by Arthur on 2020/4/20.
//

#import "CQNetManHttpRequestSerializer.h"

@implementation CQNetManHttpRequestSerializer

-(void)requestWithMethod:(NSString *)methodType URLString:(NSString *)urlString parameters:(NSDictionary *)params error:(NSError **)error{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //检查URL是否存在问题
    //检查MethodType是否能正确转化成对应的方法
    //检查参数是否标准
    //检查生成过程是否存在问题
    
}

@end

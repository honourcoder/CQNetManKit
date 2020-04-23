//
//  CQNetManErrorHandler.m
//  CQNetManKit
//
//  Created by Arthur on 2020/4/22.
//

#import "CQNetManErrorHandler.h"

@implementation CQNetManErrorHandler

+(NSError *)ErrorWithErrorCode:(CQNetManErrorCode)errorCode WithDescString:(NSString *)descString{
    if(descString == nil || [descString isEqual:[NSNull null]]){
        descString = @"";
    }
    NSDictionary *dic = nil;
    switch (errorCode) {
        case CQNetManErrorCodeUnknown:
            {
                dic = @{@"userInfo" : @"未知错误"};
            }
            break;
        case CQNetManErrorCodeURLError:
            {
                dic = @{@"userInfo" : [NSString stringWithFormat:@"[ULR错误]:%@",descString]};
            }
        break;
        case CQNetManErrorCodeParamError:
            {
                dic = @{@"userInfo" :[NSString stringWithFormat:@"[参数错误]:%@",descString]};
            }
            break;
        case CQNetManErrorCodeFormatError:
            {
                dic = @{@"userInfo" : [NSString stringWithFormat:@"[格式错误]:%@",descString]};
            }
        break;
        default:
            break;
    }
    return [NSError errorWithDomain:@"CQNetManKit" code:errorCode userInfo:dic];
}

@end

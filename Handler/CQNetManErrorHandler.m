//
//  CQNetManErrorHandler.m
//  CQNetManKit
//
//  Created by Arthur on 2020/4/22.
//

#import "CQNetManErrorHandler.h"

@implementation CQNetManErrorHandler

+(NSError *)ErrorWithErrorCode:(CQNetManErrorCode)errorCode{
    NSDictionary *dic = nil;
    switch (errorCode) {
        case CQNetManErrorCodeUnknown:
            {}
            break;
        case CQNetManErrorCodeURLError:
            {}
        break;
        case CQNetManErrorCodeParamError:
            {}
            break;
        case CQNetManErrorCodeFormatError:
            {}
        break;
        default:
            break;
    }
    return [NSError errorWithDomain:@"CQNetManKit" code:errorCode userInfo:dic];
}

@end

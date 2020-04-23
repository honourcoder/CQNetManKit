//
//  CQNetManErrorHandler.h
//  CQNetManKit
//
//  Created by Arthur on 2020/4/22.
//

#import <Foundation/Foundation.h>
#import "CQNetManDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQNetManErrorHandler : NSObject

+(NSError *)ErrorWithErrorCode:(CQNetManErrorCode)errorCode WithDescString:(NSString *)descString;

@end

NS_ASSUME_NONNULL_END

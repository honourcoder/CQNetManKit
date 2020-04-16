//
//  NSObject+NMNetWorkingAutoCancle.h
//  CQNetManKit
//
//  Created by Arthur on 2020/4/16.
//

#import <Foundation/Foundation.h>
#import "CQNetManAutoCancelHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NMNetWorkingAutoCancel)

@property (nonatomic, strong, readonly) CQNetManAutoCancelHandler *netManAutoCancelRequests;

@end

NS_ASSUME_NONNULL_END

//
//  NSObject+NMNetWorkingAutoCancle.m
//  CQNetManKit
//
//  Created by Arthur on 2020/4/16.
//

#import "NSObject+NMNetWorkingAutoCancel.h"
#import <objc/runtime.h>

@implementation NSObject (NMNetWorkingAutoCancel)


-(CQNetManAutoCancelHandler *)netManAutoCancelRequests
{
    
    CQNetManAutoCancelHandler *requests = objc_getAssociatedObject(self, @selector(netManAutoCancelRequests));
    if (requests == nil) {
        requests = [[CQNetManAutoCancelHandler alloc]init];
        objc_setAssociatedObject(self, @selector(netManAutoCancelRequests), requests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return requests;
}


@end

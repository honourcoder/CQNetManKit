//
//  NSString+NetMan.m
//  CQNetManKit
//
//  Created by Arthur on 2020/4/16.

#import "NSString+NetMan.h"

@implementation NSString (NetMan)

+(BOOL)isEmptyString:(NSString *)string
{
    if (!string) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    return string.length == 0;
}

@end

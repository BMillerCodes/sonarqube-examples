#import <Foundation/Foundation.h>

@interface Helper : NSObject
+ (int)multiply:(int)a b:(int)b;
+ (BOOL)isValid:(int)value;
+ (NSString *)formatMessage:(NSString *)message;
@end
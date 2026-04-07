#import "Helper.h"

@implementation Helper
+ (int)multiply:(int)a b:(int)b {
    return a * b;
}
+ (BOOL)isValid:(int)value {
    return value >= 0 && value <= 100;
}
+ (NSString *)formatMessage:(NSString *)message {
    return [NSString stringWithFormat:@"[INFO] %@", message];
}
@end
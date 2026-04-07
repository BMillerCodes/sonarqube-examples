#import <Foundation/Foundation.h>

@interface Calculator : NSObject
+ (int)add:(int)a b:(int)b;
+ (int)divide:(int)a by:(int)b;
@end

@implementation Calculator
+ (int)add:(int)a b:(int)b {
    return a + b;
}
+ (int)divide:(int)a by:(int)b {
    if (b == 0) {
        @throw [NSException exceptionWithName:@"DivisionByZero" reason:@"Division by zero" userInfo:nil];
    }
    return a / b;
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Hello from Objective-C SonarQube example!");

        int result = [Calculator add:5 b:3];
        NSLog(@"5 + 3 = %d", result);

        @try {
            result = [Calculator divide:10 by:0];
            NSLog(@"Result: %d", result);
        } @catch (NSException *exception) {
            NSLog(@"Error: %@", [exception reason]);
        }
    }
    return 0;
}
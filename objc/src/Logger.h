#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LogLevel) {
    LogLevelDebug = 0,
    LogLevelInfo = 1,
    LogLevelWarning = 2,
    LogLevelError = 3
};

@interface Logger : NSObject

+ (instancetype)sharedLogger;
+ (void)setLogLevel:(LogLevel)level;
+ (void)logDebug:(NSString *)message;
+ (void)logInfo:(NSString *)message;
+ (void)logWarning:(NSString *)message;
+ (void)logError:(NSString *)message;
+ (void)logMessage:(NSString *)message withLevel:(LogLevel)level;

@end

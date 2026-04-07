#import "Logger.h"

@interface Logger ()
@property (nonatomic, assign) LogLevel minimumLogLevel;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation Logger

+ (instancetype)sharedLogger {
    static Logger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _minimumLogLevel = LogLevelDebug;
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

+ (void)setLogLevel:(LogLevel)level {
    [self sharedLogger].minimumLogLevel = level;
}

+ (void)logDebug:(NSString *)message {
    [[self sharedLogger] logMessage:message withLevel:LogLevelDebug];
}

+ (void)logInfo:(NSString *)message {
    [[self sharedLogger] logMessage:message withLevel:LogLevelInfo];
}

+ (void)logWarning:(NSString *)message {
    [[self sharedLogger] logMessage:message withLevel:LogLevelWarning];
}

+ (void)logError:(NSString *)message {
    [[self sharedLogger] logMessage:message withLevel:LogLevelError];
}

+ (void)logMessage:(NSString *)message withLevel:(LogLevel)level {
    Logger *logger = [self sharedLogger];
    
    if (level < logger.minimumLogLevel) {
        return;
    }
    
    NSString *levelString;
    switch (level) {
        case LogLevelDebug:
            levelString = @"DEBUG";
            break;
        case LogLevelInfo:
            levelString = @"INFO";
            break;
        case LogLevelWarning:
            levelString = @"WARNING";
            break;
        case LogLevelError:
            levelString = @"ERROR";
            break;
    }
    
    NSString *timestamp = [logger.dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"[%@] [%@] %@", timestamp, levelString, message);
}

@end

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (NSString *)trimString:(NSString *)input;
+ (NSString *)capitalizeString:(NSString *)input;
+ (BOOL)isEmptyString:(NSString *)input;
+ (NSArray *)splitString:(NSString *)input byDelimiter:(NSString *)delimiter;
+ (NSString *)joinArray:(NSArray *)array withDelimiter:(NSString *)delimiter;

@end

#import "StringUtils.h"

@implementation StringUtils

+ (NSString *)trimString:(NSString *)input {
    return [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString *)capitalizeString:(NSString *)input {
    if (input == nil) {
        return nil;
    }
    return [input capitalizedString];
}

+ (BOOL)isEmptyString:(NSString *)input {
    return input == nil || [input length] == 0;
}

+ (NSArray *)splitString:(NSString *)input byDelimiter:(NSString *)delimiter {
    if (input == nil || delimiter == nil) {
        return nil;
    }
    return [input componentsSeparatedByString:delimiter];
}

+ (NSString *)joinArray:(NSArray *)array withDelimiter:(NSString *)delimiter {
    if (array == nil) {
        return @"";
    }
    return [array componentsJoinedByString:delimiter];
}

@end

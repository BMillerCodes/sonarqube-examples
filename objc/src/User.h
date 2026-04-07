#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, retain) NSDate *createdAt;

- (instancetype)initWithId:(NSString *)userId name:(NSString *)name email:(NSString *)email;
- (void)displayInfo;
@end

#import "User.h"

@implementation User

- (instancetype)initWithId:(NSString *)userId name:(NSString *)name email:(NSString *)email {
    self = [super init];
    if (self) {
        _userId = userId;
        _name = name;
        _email = email;
        _createdAt = [[NSDate alloc] init];
    }
    return self;
}

- (void)displayInfo {
    NSLog(@"User: %@, Name: %@, Email: %@", self.userId, self.name, self.email);
}

@end

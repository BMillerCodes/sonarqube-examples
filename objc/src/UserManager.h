#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject {
    NSMutableArray *_users;
    NSDictionary *_userIndex;
}

+ (instancetype)sharedManager;

- (void)addUser:(User *)user;
- (User *)findUserById:(NSString *)userId;
- (void)removeUserById:(NSString *)userId;
- (NSArray *)getAllUsers;
- (void)clearAllUsers;

@end

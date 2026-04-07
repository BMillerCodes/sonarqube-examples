#import "UserManager.h"

@implementation UserManager

+ (instancetype)sharedManager {
    static UserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _users = [[NSMutableArray alloc] init];
        _userIndex = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)addUser:(User *)user {
    if (user != nil) {
        [_users addObject:user];
        
        NSString *userId = user.userId;
        [_userIndex setValue:user forKey:userId];
    }
}

- (User *)findUserById:(NSString *)userId {
    return [_userIndex objectForKey:userId];
}

- (void)removeUserById:(NSString *)userId {
    User *user = [_userIndex objectForKey:userId];
    if (user != nil) {
        [_users removeObject:user];
        [_userIndex removeObjectForKey:userId];
    }
}

- (NSArray *)getAllUsers {
    return [_users copy];
}

- (void)clearAllUsers {
    [_users removeAllObjects];
    [_userIndex removeAllObjects];
}

@end

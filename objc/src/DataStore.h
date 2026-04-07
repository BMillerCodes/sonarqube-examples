#import <Foundation/Foundation.h>

@interface DataStore : NSObject {
    NSMutableData *_dataBuffer;
    NSString *_filePath;
    NSArray *_cachedItems;
}

- (instancetype)initWithFilePath:(NSString *)path;
- (void)loadData;
- (void)saveData:(NSData *)data;
- (void)appendData:(NSData *)data;
- (NSData *)getData;
- (void)clearBuffer;

@end

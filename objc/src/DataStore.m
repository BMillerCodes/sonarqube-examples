#import "DataStore.h"

@implementation DataStore

- (instancetype)initWithFilePath:(NSString *)path {
    self = [super init];
    if (self) {
        _filePath = path;
        _dataBuffer = [[NSMutableData alloc] init];
        _cachedItems = [[NSArray alloc] init];
    }
    return self;
}

- (void)loadData {
    if (_filePath != nil) {
        NSData *fileData = [NSData dataWithContentsOfFile:_filePath];
        if (fileData) {
            [_dataBuffer setData:fileData];
        }
    }
}

- (void)saveData:(NSData *)data {
    if (data != nil && _filePath != nil) {
        [data writeToFile:_filePath atomically:YES];
    }
}

- (void)appendData:(NSData *)data {
    if (data != nil) {
        [_dataBuffer appendData:data];
    }
}

- (NSData *)getData {
    return _dataBuffer;
}

- (void)clearBuffer {
    [_dataBuffer setLength:0];
    _cachedItems = nil;
}

@end

#import <Foundation/Foundation.h>

@protocol NetworkHandlerDelegate <NSObject>
- (void)didReceiveResponse:(NSData *)data;
- (void)didFailWithError:(NSError *)error;
@end

@interface NetworkHandler : NSObject <NSURLConnectionDelegate> {
    NSURLConnection *_connection;
    NSMutableData *_responseData;
    NSString *_baseURL;
}

@property (nonatomic, weak) id<NetworkHandlerDelegate> delegate;

- (instancetype)initWithBaseURL:(NSString *)baseURL;
- (void)fetchDataFromEndpoint:(NSString *)endpoint;
- (void)postData:(NSData *)data toEndpoint:(NSString *)endpoint;
- (void)cancelRequest;

@end

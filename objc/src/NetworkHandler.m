#import "NetworkHandler.h"

@implementation NetworkHandler

- (instancetype)initWithBaseURL:(NSString *)baseURL {
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _responseData = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)fetchDataFromEndpoint:(NSString *)endpoint {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", _baseURL, endpoint];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (url == nil) {
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_connection start];
}

- (void)postData:(NSData *)data toEndpoint:(NSString *)endpoint {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", _baseURL, endpoint];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (url == nil || data == nil) {
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_connection start];
}

- (void)cancelRequest {
    [_connection cancel];
    _connection = nil;
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_delegate didReceiveResponse:_responseData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [_delegate didFailWithError:error];
}

@end

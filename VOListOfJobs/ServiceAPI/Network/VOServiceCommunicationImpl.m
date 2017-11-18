//
//  VOServiceCommunicationImpl.m
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import "VOServiceCommunicationImpl.h"
#import "VOJsonParser.h"
#import "VOLoadDataResponse.h"
@import AFNetworking;

NSString * const kCurrentAddress = @"https://www.coople.com/resources/api/work-assignments/public-jobs";




@implementation VOServiceCommunicationImpl

- (NSURL *)urlWithWebMethod:(NSString *)webMethod
{
    NSURL *serviceURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",
                                               kCurrentAddress,
                                               webMethod]];
    return serviceURL;
}

- (void)sendData:(NSDictionary *)params
   serviceMethod:(NSString *)serviceMethod
 completeHandler:(void (^)(NSDictionary *jsonData, NSError *error))completeHandler
{
    
    NSURL *url = [self urlWithWebMethod:serviceMethod];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    
    [manager GET:url.absoluteString parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        VOJsonParser *jsonParser = [[VOJsonParser alloc] init];
        NSDictionary *jsonData = responseObject;
        VOServerPesponse *serverResponse = [jsonParser parseServerResponse:jsonData];
        if (serverResponse.isError)
        {
            NSError *errorResponse = [NSError errorWithDomain:@"Error JSON parser" code:-1 userInfo:nil];
            completeHandler(jsonData, errorResponse);
            return;
        }
        completeHandler(responseObject, nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completeHandler(nil, error);
        
    }];
 
}



@end

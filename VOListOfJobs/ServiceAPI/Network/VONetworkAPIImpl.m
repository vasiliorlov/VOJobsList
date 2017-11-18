//
//  VONetworkAPIImpl.m
//  VOListOfJobs
//
//  Created by iMac on 17.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import "VONetworkAPIImpl.h"
#import "VOServiceCommunicationImpl.h"
#import "VOJsonParser.h"

NSString * const kWebMethod = @"list";
NSUInteger const kJobOnPage = 200;

@interface VONetworkAPIImpl(){
    id<VOServiceCommunication> downloadManager;
}
@end

@implementation VONetworkAPIImpl
- (void)getJobsWithCompleteHandler:(void(^)(VOLoadDataResponse * response, NSError * error))completeHandler{
    
    NSUInteger downloadJobs = 0;
    NSUInteger downloadPage = 0;
    downloadManager = [[VOServiceCommunicationImpl alloc] init];
    
    
    NSDictionary *dictionary = @{@"pageNum":[NSNumber numberWithUnsignedInteger:downloadPage],@"pageSize":[NSNumber numberWithUnsignedInteger:kJobOnPage]};
    
    
    [downloadManager sendData:dictionary serviceMethod:kWebMethod completeHandler:^(NSDictionary *jsonData, NSError *error) {
        if(error == nil){
            VOJsonParser *jsonParser = [[VOJsonParser alloc] init];
            VOLoadDataResponse *serverResponse = [jsonParser parseLoadDataResponse:jsonData];
            completeHandler(serverResponse, nil);
        } else{
            completeHandler(nil, error);
        }
        
    }];
}
@end

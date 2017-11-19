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
#import "VOLoadDataResponse.h"

NSString * const kWebMethod = @"list";
NSUInteger const kDownloadJobsAtTime = 200;

@interface VONetworkAPIImpl(){
    id<VOServiceCommunication> downloadManager;
    VOLoadDataResponse *loadDataResponse;
    NSUInteger downloadPages;
    NSUInteger totalJobs;
}
@end

@implementation VONetworkAPIImpl
- (void)getJobsWithCompleteHandler:(void(^)(VOLoadDataResponse * response, NSError * error))completeHandler{
    
    
    NSUInteger downloadPage = 0;
    totalJobs = 0;
    
    downloadManager = [[VOServiceCommunicationImpl alloc] init];
    
    
    NSDictionary *dictionary = @{@"pageNum":[NSNumber numberWithUnsignedInteger:downloadPage],@"pageSize":[NSNumber numberWithUnsignedInteger:kDownloadJobsAtTime]};
    
    __weak typeof(self) wSelf = self;
    [downloadManager sendData:dictionary serviceMethod:kWebMethod completeHandler:^(NSDictionary *jsonData, NSError *error) {
        __strong typeof(self) sSelf = wSelf;
        if(error == nil){
            VOJsonParser *jsonParser = [[VOJsonParser alloc] init];
            loadDataResponse = [jsonParser parseLoadDataResponse:jsonData];
            totalJobs = loadDataResponse.total;
            if (totalJobs <= kDownloadJobsAtTime){
                completeHandler(loadDataResponse, nil);
            } else {
                [sSelf downloadNextPagesWithCompleteHandler:completeHandler];
            }
        } else{
            completeHandler(nil, error);
        }
        
    }];
}
-(void)downloadNextPagesWithCompleteHandler:(void(^)(VOLoadDataResponse * response, NSError * error))completeHandler{
    
    
    NSInteger pages = (totalJobs / kDownloadJobsAtTime);
    downloadPages = pages ;
    for (NSInteger page = 1; page <= pages; page++){
        NSDictionary *dictionary = @{@"pageNum":[NSNumber numberWithUnsignedInteger:page],@"pageSize":[NSNumber numberWithUnsignedInteger:kDownloadJobsAtTime]};
        [downloadManager sendData:dictionary serviceMethod:kWebMethod completeHandler:^(NSDictionary *jsonData, NSError *error) {
            @synchronized(self){
                if(error == nil){
                    VOJsonParser *jsonParser = [[VOJsonParser alloc] init];
                    NSArray<VOJob*> *tempJobs = [jsonParser parseLoadDataResponse:jsonData].jobs;
                    [loadDataResponse.jobs addObjectsFromArray:tempJobs];
                }
                
                downloadPages = downloadPages - 1;
                if (downloadPages == 0){
                    completeHandler(loadDataResponse,nil);
                }
            }
        }];
        
    }
    
}
@end

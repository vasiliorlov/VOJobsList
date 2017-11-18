//
//  VOJobsListInteractor.m
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import "VOJobsListInteractor.h"
#import "VOJobsListInteractorOutput.h"
#import "VOLoadDataResponse.h"


@implementation VOJobsListInteractor

#pragma mark - Методы VOJobsListInteractorInput
-(void)getLocalJobs{
    NSArray<VOJob*> *jobs =  [self.dataStoreAPI readAllJobs];
    [self.output returnLocalJobs:jobs error:nil];
}
-(void)getRemoteJobs{
    
    [self.networkAPI getJobsWithCompleteHandler:^(VOLoadDataResponse *response, NSError *error) {
        __strong typeof(self) sSelf = self;
        if (error == nil){
            NSArray<VOJob*> *jobs =  response.jobs;
            [sSelf.dataStoreAPI clearAllJobs];
            [sSelf.dataStoreAPI saveJobs:jobs];
            [sSelf.output returnRemoteJobs:jobs error:nil];
        } else {
            [sSelf.output returnRemoteJobs:nil error:error];
        }
    }];
}
@end

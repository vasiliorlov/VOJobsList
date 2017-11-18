//
//  VOJobsListInteractor.h
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import "VOJobsListInteractorInput.h"
#import "VODataStoreAPI.h"
#import "VONetworkAPI.h"

@protocol VOJobsListInteractorOutput;

@interface VOJobsListInteractor : NSObject <VOJobsListInteractorInput>

@property (nonatomic, weak) id<VOJobsListInteractorOutput> output;
@property (nonatomic, strong) id<VONetworkAPI> networkAPI;
@property (nonatomic,strong) id<VODataStoreAPI> dataStoreAPI;

@end

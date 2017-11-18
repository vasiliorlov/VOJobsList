//
//  VOJobsListPresenter.h
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import "VOJobsListViewOutput.h"
#import "VOJobsListInteractorOutput.h"
#import "VOJobsListModuleInput.h"

@protocol VOJobsListViewInput;
@protocol VOJobsListInteractorInput;
@protocol VOJobsListRouterInput;

@interface VOJobsListPresenter : NSObject <VOJobsListModuleInput, VOJobsListViewOutput, VOJobsListInteractorOutput>

@property (nonatomic, weak) id<VOJobsListViewInput> view;
@property (nonatomic, strong) id<VOJobsListInteractorInput> interactor;
@property (nonatomic, strong) id<VOJobsListRouterInput> router;

@end

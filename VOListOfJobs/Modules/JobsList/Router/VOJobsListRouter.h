//
//  VOJobsListRouter.h
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import "VOJobsListRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface VOJobsListRouter : NSObject <VOJobsListRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end

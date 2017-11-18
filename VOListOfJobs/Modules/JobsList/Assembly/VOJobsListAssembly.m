//
//  VOJobsListAssembly.m
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import "VOJobsListAssembly.h"

#import "VOJobsListViewController.h"
#import "VOJobsListInteractor.h"
#import "VOJobsListPresenter.h"
#import "VOJobsListRouter.h"
#import "VONetworkAPIImpl.h"
#import "VODataStoreAPIImpl.h"


@implementation VOJobsListAssembly

- (VOJobsListViewController *)viewJobsList {
    return [TyphoonDefinition withClass:[VOJobsListViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterJobsList]];
       //                       [definition injectProperty:@selector(moduleInput)
       //                                             with:[self presenterJobsList]];
                              
                          }];
}

- (VOJobsListInteractor *)interactorJobsList {
    return [TyphoonDefinition withClass:[VOJobsListInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterJobsList]];
                              [definition injectProperty:@selector(networkAPI)
                                                    with:[self networkManager]];
                              [definition injectProperty:@selector(dataStoreAPI)
                                                    with:[self dataStoreManager]];
                          }];
}

- (VOJobsListPresenter *)presenterJobsList{
    return [TyphoonDefinition withClass:[VOJobsListPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewJobsList]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorJobsList]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerJobsList]];
                          }];
}

- (VOJobsListRouter *)routerJobsList{
    return [TyphoonDefinition withClass:[VOJobsListRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewJobsList]];
                          }];
}

- (id<VONetworkAPI>)networkManager{
    return [TyphoonDefinition withClass:[VONetworkAPIImpl class]
                          configuration:^(TyphoonDefinition *definition) {
                          }];
}
- (id<VODataStoreAPI>)dataStoreManager{
    return [TyphoonDefinition withClass:[VODataStoreAPIImpl class]
                          configuration:^(TyphoonDefinition *definition) {
                          }];
    
}
@end

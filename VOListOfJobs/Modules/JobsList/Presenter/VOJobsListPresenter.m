//
//  VOJobsListPresenter.m
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import "VOJobsListPresenter.h"

#import "VOJobsListViewInput.h"
#import "VOJobsListInteractorInput.h"
#import "VOJobsListRouterInput.h"
#import "VOMasterParser.h"

@implementation VOJobsListPresenter

#pragma mark - Методы VOJobsListModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы VOJobsListViewOutput

- (void)didTriggerViewReadyEvent {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [self.interactor getLocalJobs];
    });
    
}
- (void)reloadJobs{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [self.interactor getRemoteJobs];
    });
}

#pragma mark - Методы VOJobsListInteractorOutput
-(void)returnLocalJobs:(NSArray<VOJob*> *)jobs error:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if (error == nil){
            [self.view updateStateWithModel:[VOMasterParser viewModelsFromJobs:jobs]];
        } else {
            [self.view showAlert:error];
        }
    });
}
-(void)returnRemoteJobs:(NSArray<VOJob*> *)jobs error:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if (error == nil){
            [self.view updateStateWithModel:[VOMasterParser viewModelsFromJobs:jobs]];
        } else {
            [self.view showAlert:error];
        }
    });
}
@end

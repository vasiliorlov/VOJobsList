//
//  VOJobsListViewInput.h
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VOJobViewModel;

@protocol VOJobsListViewInput <NSObject>

/**
 @author orlov

 Метод настраивает начальный стейт view
 */
- (void)setupInitialState;
- (void)updateStateWithModel:(NSArray<VOJobViewModel*>*)models;
- (void)showAlert:(NSError *)error;

@end

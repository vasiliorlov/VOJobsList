//
//  VOJobsListViewOutput.h
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VOJobsListViewOutput <NSObject>

/**
 @author orlov

 Метод сообщает презентеру о том, что view готова к работе
 */
- (void)didTriggerViewReadyEvent;
- (void)reloadJobs;

@end

//
//  VOJobsListViewController.h
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VOJobsListViewInput.h"

@protocol VOJobsListViewOutput;

@interface VOJobsListViewController : UIViewController <VOJobsListViewInput, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id<VOJobsListViewOutput> output;

@end

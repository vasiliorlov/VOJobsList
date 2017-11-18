//
//  VOJobsListViewController.m
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import "VOJobsListViewController.h"
#import "VOJobsListViewOutput.h"
#import "VOJobViewModel.h"
#import "VOJobTableViewCell.h"

NSString * const kCellIndef = @"jobCell";
@interface VOJobsListViewController(){
    
    IBOutlet UITableView *tableView;
    NSArray<VOJobViewModel*>* jobModels;
}
@end

@implementation VOJobsListViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                  target:self
                                                                                  action:@selector(btnRefreshJobsTouchIn:)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = searchButton;
    self.title = @"Jobs list";
    
    [tableView registerClass:[VOJobTableViewCell class] forCellReuseIdentifier:kCellIndef];
    
    [self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы VOJobsListViewInput
- (void)setupInitialState{
    
}
- (void)updateStateWithModel:(NSArray<VOJobViewModel*>*)models{
    jobModels = models;
    if (self.presentedViewController){
        [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:0]  withRowAnimation:YES];
        }];
    }else {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:0]  withRowAnimation:YES];
    }
}

- (void)showAlert:(NSError *)error{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.domain preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    [alert addAction:action];
    
    if (self.presentedViewController){
        [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [self presentViewController:alert animated:YES completion:^{}];
        }];
    }else{
        [self presentViewController:alert animated:YES completion:^{}];
    }
}
#pragma mark - Методы user TiuchIn
- (IBAction)btnRefreshJobsTouchIn:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Refresh jobs" message:@"Loading new jobs. Please wait." preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{}];
    [self.output reloadJobs];
    
    // do something or handle Search Button Action.
}

#pragma mark - Методы UItableViewDeleagete, UITableViewSourde
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return jobModels.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VOJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIndef forIndexPath:indexPath];
    
    VOJobViewModel *model = jobModels[indexPath.row];
    [cell setupStateWithModel:model];
    return cell;
    
}
@end

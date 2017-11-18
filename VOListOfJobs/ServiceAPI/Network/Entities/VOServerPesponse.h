//
//  VOServerPesponse.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VOServerPesponse : NSObject
@property (nonatomic, assign)    BOOL       isError;
@property (nonatomic, assign)    int        status;
@property (nonatomic, strong)    NSString   *errorCode;
@end

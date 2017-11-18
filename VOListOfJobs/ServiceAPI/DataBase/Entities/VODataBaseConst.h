//
//  VODataBaseConst.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>

OBJC_EXTERN NSString *   Db_DatabaseName;

#pragma mark - main tables

OBJC_EXTERN const char * Db_Table_Jobs;
#pragma mark - main fields
OBJC_EXTERN const char * Db_Field_Id;
OBJC_EXTERN const char * Db_Field_Jobs_Id;
OBJC_EXTERN const char * Db_Field_Jobs_Name;

OBJC_EXTERN const char * Db_Field_Jobs_Adr_Street;
OBJC_EXTERN const char * Db_Field_Jobs_Adr_Zip;
OBJC_EXTERN const char * Db_Field_Jobs_Adr_City;

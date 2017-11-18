//
//  VODataBaseConst.m
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import "VODataBaseConst.h"
NSString *   Db_DatabaseName                = @"jobs.sqlite";

const char * Db_Table_Jobs  = "jobs";

#pragma mark - main fields
const char * Db_Field_Id                        = "_id";
const char * Db_Field_Jobs_Id                   = "jobs_id";
const char * Db_Field_Jobs_Name                 = "jobs_name";;

const char * Db_Field_Jobs_Adr_Street           = "jobs_adr_street";;
const char * Db_Field_Jobs_Adr_Zip              = "jobs_adr_zip";;
const char * Db_Field_Jobs_Adr_City             = "jobs_adr_city";;

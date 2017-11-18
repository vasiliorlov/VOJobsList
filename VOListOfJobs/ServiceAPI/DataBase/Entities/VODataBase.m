//
//  VODataBase.m
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import "VODataBase.h"
#import "VODataBaseConst.h"
static VODataBase *__databaseInstance;
static int database_version = 1;


@implementation VODataBase
@synthesize databaseMutex, databasePath, sqliteDatabase, databaseOpened;
+ (instancetype)sharedInstance
{
    static dispatch_once_t dbOnceToken;
    dispatch_once(&dbOnceToken, ^{
        __databaseInstance = [[VODataBase alloc] init];
    });
    return __databaseInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.databasePath = [self getDatabaseAddress];
        databaseMutex = [[NSObject alloc] init];
    }
    return self;
}
- (NSString *)getDatabaseAddress
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [[NSString alloc] initWithString: [paths objectAtIndex:0]];
    NSString *writableDBPath = [NSString stringWithString: [documentsDirectory stringByAppendingPathComponent:Db_DatabaseName]];
    return writableDBPath;
}

- (BOOL)openDatabaseReadOnly:(BOOL)readOnly
{
    [self printMethodCaller];
    
    const char *db_path = [databasePath UTF8String];
    int flags = (readOnly) ? SQLITE_OPEN_READONLY : SQLITE_OPEN_READWRITE;
    flags = flags | SQLITE_OPEN_FULLMUTEX;
    
    int open_db_state = sqlite3_open(db_path, &sqliteDatabase);
    if (open_db_state != SQLITE_OK) {
        NSLog(@"%@",[NSThread callStackSymbols]);
        NSAssert(NO, @"Error in opening database: %s", sqlite3_errmsg(sqliteDatabase));
        return NO;
    }
    
    if (!readOnly) {
        sqlite3_exec(sqliteDatabase, "PRAGMA foreign_keys = ON;", 0, 0, 0);
    }
    
    databaseOpened = YES;
    return YES;
}
- (void)closeDatabase
{
    [self printMethodCaller];
    
    if (databaseOpened) {
        int state = sqlite3_close(sqliteDatabase);
        NSAssert(state == SQLITE_OK, @"Error in closing database: %s", sqlite3_errmsg(sqliteDatabase));
        databaseOpened = NO;
    }
}

- (void)removeDatabase
{
    if (databaseOpened) {
        [self closeDatabase];
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *err = nil;
    [fm removeItemAtPath:databasePath error:&err];
    
    NSAssert(err == nil, @"Error deleting database: %@", err.localizedDescription);
}

- (void)startTransaction
{
    [self printMethodCaller];
    
    if (!databaseOpened) {
        NSAssert(NO, @"Can't start transaction - database is closed");
    }
    int state = sqlite3_exec(sqliteDatabase, "BEGIN TRANSACTION", 0, 0, 0);
    NSAssert(state == SQLITE_OK, @"Can't start transaction, err: %s", sqlite3_errmsg(sqliteDatabase));
}

- (void)commitTransaction
{
    [self printMethodCaller];
    
    if (!databaseOpened) {
        NSAssert(NO, @"Can't commit transaction - database is closed");
    }
    int state = sqlite3_exec(sqliteDatabase, "COMMIT TRANSACTION", 0, 0, 0);
    NSAssert(state == SQLITE_OK, @"Can't commit transaction, err: %s", sqlite3_errmsg(sqliteDatabase));
}

- (void)printMethodCaller
{
#ifdef DEBUG
    
    NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
    
    NSString *callableInfoString = [[NSThread callStackSymbols] objectAtIndex:1];
    NSMutableArray *arrayCallable = [NSMutableArray arrayWithArray:[callableInfoString  componentsSeparatedByCharactersInSet:separatorSet]];
    [arrayCallable removeObject:@""];
    
    NSString *callerInfoString = [[NSThread callStackSymbols] objectAtIndex:2];
    NSMutableArray *arrayCaller = [NSMutableArray arrayWithArray:[callerInfoString  componentsSeparatedByCharactersInSet:separatorSet]];
    [arrayCaller removeObject:@""];
    
    NSLog(@"[%@ %@] -> [%@ %@]", [arrayCaller objectAtIndex:3], [arrayCaller objectAtIndex:4], [arrayCallable objectAtIndex:3], [arrayCallable objectAtIndex:4]);
    
#endif
}

- (BOOL)isDatabaseCreated
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL databaseExists = [fileManager fileExistsAtPath:databasePath];
    
    return databaseExists;
}


- (BOOL)createDatabase
{
    @synchronized(databaseMutex)
    {
        int state = 0;
        BOOL isSuccess = YES;
        
        sqlite3 * db = nil;
        state = sqlite3_open_v2([databasePath UTF8String], &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL);
        isSuccess = state == SQLITE_OK;
        if (!isSuccess) {
            return NO;
        }
        
        // create tables
        //
        
        NSString * dbVersionSql = [NSString stringWithFormat:@"PRAGMA user_version = %d", database_version];
        
#pragma mark cus tables
        
        NSString *cusTableSql = [NSString stringWithFormat:@"CREATE TABLE [%s] ("
                                  "[%s] INTEGER PRIMARY KEY NOT NULL,"
                                  "[%s] TEXT             NOT NULL,"
                                  "[%s] TEXT             NULL,"
                                  "[%s] TEXT             NULL,"
                                  "[%s] TEXT             NULL,"
                                  "[%s] TEXT             NULL,"
                                  "UNIQUE (%s) ON CONFLICT REPLACE"
                                  ");", Db_Table_Jobs, Db_Field_Id, Db_Field_Jobs_Id, Db_Field_Jobs_Name, Db_Field_Jobs_Adr_Street, Db_Field_Jobs_Adr_Zip, Db_Field_Jobs_Adr_City, Db_Field_Jobs_Id];
        
   
        
        
        NSArray * sqlQueries = @[dbVersionSql, cusTableSql];
        
        state = sqlite3_exec(db, "BEGIN TRANSACTION", 0, 0, 0);
        for (NSString * query in sqlQueries) {
            state = sqlite3_exec(db, [query UTF8String], 0, 0, 0);
            NSAssert(state == SQLITE_OK, @"%s: sql <%@> %s", __FUNCTION__, query, sqlite3_errmsg(db));
        }
        state = sqlite3_exec(db, "COMMIT", 0, 0, 0);
        sqlite3_close(db);
        
        return YES;
    }
}
- (void)clearSessionData
{
    [self openDatabaseReadOnly:NO];
    [self startTransaction];
    
    const char *tables_to_clear[] = { Db_Table_Jobs};
    int tables_number = sizeof(tables_to_clear) / sizeof(const char *);
    int state = 0;
    
    for (int i = 0; i < tables_number; i++)
    {
        const char *table_name = tables_to_clear[i];
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %s", table_name];
        state = sqlite3_exec(sqliteDatabase, [sql UTF8String], 0, 0, 0);
        NSAssert(state == SQLITE_OK, @"%s: sql \"%@\" %s", __FUNCTION__, sql, sqlite3_errmsg(sqliteDatabase));
    }
    
    [self commitTransaction];
    [self closeDatabase];
}
@end

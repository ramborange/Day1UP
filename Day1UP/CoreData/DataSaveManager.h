//
//  DataSaveManager.h
//  Day1UP
//
//  Created by ramborange on 16/10/9.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"
#import "TestModel.h"
@interface DataSaveManager : NSObject<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *results;
@property (nonatomic, strong) NSManagedObjectContext *context;

+ (DataSaveManager *)shareDataSaveManager;

- (void)addTest:(Test *)test;
- (void)removeTest:(TestModel *)testModel;
- (void)removeAllTests;
- (TestModel *)getTestMoelWith:(NSString *)tid;
- (NSArray *)getAllTests;

- (void)saveUpdate;
@end

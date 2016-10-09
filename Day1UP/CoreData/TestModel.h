//
//  TestModel.h
//  Day1UP
//
//  Created by ramborange on 16/10/9.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface TestModel : NSManagedObject
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *arg;
@property (nonatomic, copy) NSString *other;
@end

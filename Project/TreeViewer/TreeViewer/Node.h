//
//  Node.h
//  TreeModel
//
//  Created by Ahmed Hesham on 1/1/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeViewerDelegate.h"

@interface Node : NSObject <TreeViewerDelegate>

@property (nonatomic, assign) id  delegate;

-(instancetype) initWithIdentifier:(NSString *)identifier andInfo:(NSDictionary *)info;
-(instancetype) initWithChildren:(NSArray *)children andIdentifier:(NSString *) identifier andInfo:(NSDictionary *)info;

//data

@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *position;


@end

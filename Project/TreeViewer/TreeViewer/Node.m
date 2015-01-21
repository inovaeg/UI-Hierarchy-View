//
//  Node.m
//  TreeModel
//
//  Created by Ahmed Hesham on 1/1/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#import "Node.h"

@interface Node()

@end

@implementation Node

@synthesize weight=_weight;
@synthesize startX=_startX;
@synthesize identifier=_identifier;
@synthesize children=_children;
@synthesize nodeView=_nodeView;
@synthesize backgroundColor=_backgroundColor;

- (void)viewTapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@"%@",self.identifier);
}

-(instancetype) initWithIdentifier:(NSString *)identifier andInfo:(NSDictionary *)info{
    self=[super init];
    if(self){
        self.name=[info objectForKey:@"Name"];
        self.imageName=[info objectForKey:@"ImageName"];
        self.position=[info objectForKey:@"Position"];
        
        self.identifier=identifier;
        self.children=[[NSMutableArray alloc]init];
    }
    return self;
}

-(instancetype) initWithChildren:(NSArray *)children andIdentifier:(NSString *) identifier andInfo:(NSDictionary *)info{
    self=[super init];
    if(self){
        self.name=[info objectForKey:@"Name"];
        self.imageName=[info objectForKey:@"ImageName"];
        self.position=[info objectForKey:@"Position"];

        self.identifier=identifier;
        self.children=[[NSMutableArray alloc]initWithCapacity:children.count];
        for(id child in children){
            if([child isKindOfClass:[Node class]])
                [self.children addObject:child];
        }
    }
    return self;
}


@end

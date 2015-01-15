//
//  Controller.m
//  TreeModel
//
//  Created by Ahmed Hesham on 1/1/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#import "Controller.h"

@implementation Controller

-(int) updateWeightForNode:(Node *)parent{
    if(parent.children.count==0)
        return 1;
    for(id child in parent.children){
        parent.weight += [self updateWeightForNode:child];
    }
    return parent.weight;
}

-(int) updateWeightsForTree:(Node *)root nodes:(NSMutableArray *)nodes{
    if(root.children.count==0){
        nodes[root.identifier-1] = [NSNumber numberWithInt:1];
        return 1;
    }
    for(id child in root.children){
        root.weight += [self updateWeightsForTree:child nodes:nodes];
    }
    nodes[root.identifier-1] = [NSNumber numberWithInt:root.weight];
    return root.weight;
}

@end
//
//  Controller.h
//  TreeModel
//
//  Created by Ahmed Hesham on 1/1/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Controller : NSObject
-(int) updateWeightForNode:(Node *)parent;
-(int) updateWeightsForTree:(Node *)root nodes:(NSMutableArray *)nodes;

@end

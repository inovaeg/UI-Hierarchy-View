//
//  TreeViewer.h
//  TreeViewer
//
//  Created by Ahmed Hesham on 12/31/14.
//  Copyright (c) 2014 Inova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeViewerDelegate.h"

@interface TreeViewer : UIView

@property (strong,nonatomic) id<TreeViewerDelegate> root;

// init the view that contains all the tree nodes
- (id)initWithFrame:(CGRect)frame andWithRoot:(id<TreeViewerDelegate>)root;

@end

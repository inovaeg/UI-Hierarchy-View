//
//  HierarchyScrollView.h
//  TreeViewer
//
//  Created by Ahmed Hesham on 1/11/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeViewer.h"

@interface HierarchyScrollView : UIScrollView

// init the scroll view that contains the treeview.
- (id)initWithFrame:(CGRect)frame andWithRoot:(id<TreeViewerDelegate>)root;

@end

//
//  TreeViewerViewController.h
//  TreeViewer
//
//  Created by Ahmed Hesham on 12/31/14.
//  Copyright (c) 2014 Inova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"
#import "CustomNodeView.h"
#import "HierarchyScrollView.h"

@interface TreeViewerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tv;

@end

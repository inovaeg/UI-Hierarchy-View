//
//  CustomNodeView.h
//  TreeViewer
//
//  Created by Ahmed Hesham on 1/21/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"

@interface CustomNodeView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *customView;

-(void)createViewWithNode :(Node *) node;

@end

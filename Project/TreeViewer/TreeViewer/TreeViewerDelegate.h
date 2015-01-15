//
//  TreeViewerDelegate.h
//  TreeViewer
//
//  Created by Ahmed Hesham on 1/14/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#ifndef TreeViewer_TreeViewerDelegate_h
#define TreeViewer_TreeViewerDelegate_h

@protocol TreeViewerDelegate

#pragma mark - view parameters:
// a custom view that user want for each node.
@property (nonatomic,strong) UIView * nodeView ;
// the weight of the node (number of leaf children).
@property (nonatomic) int weight;
// start x position of node.
@property (nonatomic) int startX;

// background of the container view of nodes
@property (nonatomic,strong) UIColor * backgroundColor ;

#pragma mark - data parameters:
// this is a unique identifier for the node
@property (nonatomic,strong) NSString *identifier;
// array of node children
@property (nonatomic,strong) NSMutableArray * children;

@required
#pragma mark - listners:
// here we handle tapping the view
- (void)viewTapped:(UITapGestureRecognizer *)recognizer ;

@end


#endif

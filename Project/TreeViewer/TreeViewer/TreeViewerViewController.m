//
//  TreeViewerViewController.m
//  TreeViewer
//
//  Created by Ahmed Hesham on 12/31/14.
//  Copyright (c) 2014 Inova. All rights reserved.
//

#import "TreeViewerViewController.h"

@interface TreeViewerViewController () <UIScrollViewDelegate>

@end

@implementation TreeViewerViewController

-(id<TreeViewerDelegate>) setup{
    
    //case 2
    Node *n10=[[Node alloc]initWithIdentifier:@"10" andInfo:@{@"Name":@"1",@"ImageName":@"1.jpg",@"Position":@"1"}];
    Node *n8=[[Node alloc]initWithIdentifier:@"8" andInfo:@{@"Name":@"2",@"ImageName":@"2.jpg",@"Position":@"2"}];
    Node *n9=[[Node alloc]initWithIdentifier:@"9" andInfo:@{@"Name":@"3",@"ImageName":@"3.jpg",@"Position":@"3"}];
    Node *n5=[[Node alloc]initWithChildren:@[n8,n9] andIdentifier:@"5" andInfo:@{@"Name":@"4",@"ImageName":@"4.jpg",@"Position":@"4"}];
    Node *n2=[[Node alloc]initWithChildren:@[n5] andIdentifier:@"2" andInfo:@{@"Name":@"5",@"ImageName":@"5.jpg",@"Position":@"5"}];
    Node *n6=[[Node alloc]initWithIdentifier:@"6" andInfo:@{@"Name":@"6",@"ImageName":@"6.jpg",@"Position":@"6"}];
    Node *n7=[[Node alloc]initWithIdentifier:@"7" andInfo:@{@"Name":@"7",@"ImageName":@"7.jpg",@"Position":@"7"}];
    Node *n4=[[Node alloc]initWithChildren:@[n6,n7,n10] andIdentifier:@"4" andInfo:@{@"Name":@"8",@"ImageName":@"8.jpg",@"Position":@"8"}];
    Node *n1=[[Node alloc]initWithChildren:@[n2,n4] andIdentifier:@"1" andInfo:@{@"Name":@"9",@"ImageName":@"9.jpg",@"Position":@"9"}];
    
    return n1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    id<TreeViewerDelegate> root = [self setup];

    HierarchyScrollView *view =[[HierarchyScrollView alloc]initWithFrame:self.view.bounds andWithRoot:root];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

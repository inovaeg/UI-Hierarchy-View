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
    // create nodes
    // add children to parent
    NSURL *employeesFile = [[NSBundle mainBundle] URLForResource:@"Employees" withExtension:@"plist"];
    NSArray *plistContent = [NSArray arrayWithContentsOfURL:employeesFile];
    
    Node *n10=[[Node alloc]initWithIdentifier:@"10" andInfo:plistContent[8]];
    Node *n8=[[Node alloc]initWithIdentifier:@"8" andInfo:plistContent[5]];
    Node *n9=[[Node alloc]initWithIdentifier:@"9" andInfo:plistContent[0]];
    Node *n5=[[Node alloc]initWithChildren:@[n8,n9] andIdentifier:@"5" andInfo:plistContent[3]];
    Node *n2=[[Node alloc]initWithChildren:@[n5] andIdentifier:@"2" andInfo:plistContent[1]];
    Node *n6=[[Node alloc]initWithIdentifier:@"6" andInfo:plistContent[7]];
    Node *n7=[[Node alloc]initWithIdentifier:@"7" andInfo:plistContent[6]];
    Node *n4=[[Node alloc]initWithChildren:@[n6,n7,n10] andIdentifier:@"4" andInfo:plistContent[4]];
    Node *n1=[[Node alloc]initWithChildren:@[n2,n4] andIdentifier:@"Ahmed Badie" andInfo:plistContent[2]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];

    NSArray *array=@[n1,n2,n4,n5,n6,n7,n8,n9,n10];
    for (int i=0;i<9;i++) {
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CustomViewConroller"];
        CustomNodeView * customView = (CustomNodeView *)[vc.view viewWithTag:25];
        [customView createViewWithNode:((Node *)array[i])];
        ((Node *)array[i]).nodeView = customView;
    }
    
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

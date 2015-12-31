//
//  TreeViewerViewController.m
//  TreeViewer
//
//  Created by Ahmed Hesham on 12/31/14.
//  Copyright (c) 2014 Inova. All rights reserved.
//

#import "TreeViewerViewController.h"
#import "CustomNodeView.h"

@interface TreeViewerViewController () <UIScrollViewDelegate>

@end

@implementation TreeViewerViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(id<TreeViewerDelegate>) setup{
    // Our Tree structure is in plist file.
    NSURL *employeesFile = [[NSBundle mainBundle] URLForResource:@"EmployeesTree" withExtension:@"plist"];
    NSDictionary *rootInfo = [NSDictionary dictionaryWithContentsOfURL:employeesFile];
    
    //traverse the tree from plist and create node.
    int count=0;
    NSMutableArray *visited=[[NSMutableArray alloc]init];
    // a queue to insert visited nodes in.
    
    Node * root= [[Node alloc] initWithIdentifier:[[NSString alloc]initWithFormat:@"i_%d",count] andInfo:rootInfo];
    NSMutableArray *queue=[[NSMutableArray alloc]init];
    NSMutableArray *nodeQueue=[[NSMutableArray alloc]init];
    NSMutableArray *nodes=[[NSMutableArray alloc]init];

    [nodeQueue addObject:root];
    [queue addObject:rootInfo];
    [visited addObject:rootInfo];
    
    while(queue.count>0){
        NSDictionary *nodeInfo=[queue objectAtIndex:0];
        Node *parent=[nodeQueue objectAtIndex:0];
        [nodes addObject:parent];
        [queue removeObjectAtIndex:0];
        [nodeQueue removeObjectAtIndex:0];
        for(id childInfo in [nodeInfo objectForKey:@"Children"]){
            if(![visited containsObject:childInfo]){
                count++;
                Node * node= [[Node alloc] initWithIdentifier:[[NSString alloc]initWithFormat:@"i_%d",count] andInfo:childInfo];
                [parent.children addObject:node];
                [nodeQueue addObject:node];
                [queue addObject:childInfo];
                [visited addObject:childInfo];
            }
        }
    }

    
    for (int i=0;i<[nodes count];i++) {
        CustomNodeView *cell = (CustomNodeView *)[self.tv dequeueReusableCellWithIdentifier:@"customCell"];
        [cell createViewWithNode:((Node *)nodes[i])];
        UIView *view = cell.customView;
        ((Node *)nodes[i]).nodeView = view;
        
 }
    
    return root;
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

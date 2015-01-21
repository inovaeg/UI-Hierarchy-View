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

// create and return our custom view
-(UIView *)createViewWithNode :(Node *) node{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 872,360)];
    view.backgroundColor=[UIColor clearColor];
    UIImage *image;
    if([node.position isEqual:@"Co-founder & CEO"])
        image=[UIImage imageNamed:@"5"];
    else if([node.position isEqual:@"Android Developer"])
        image=[UIImage imageNamed:@"1"];
    else if([node.position isEqual:@"Team Leader"])
        image=[UIImage imageNamed:@"3"];
    else if([node.position isEqual:@"Co-founder"])
        image=[UIImage imageNamed:@"4"];
    else if([node.position isEqual:@"iOS Developer"])
        image=[UIImage imageNamed:@"6"];
    else
        image=[UIImage imageNamed:@"2"];
    
    UIImage *nodeImage=[UIImage imageNamed:node.imageName];
    UIImageView *nodeImageView = [[UIImageView alloc] initWithImage:nodeImage];
    
    nodeImageView.frame = CGRectMake(0.95*view.bounds.size.width/28,2.4*view.bounds.size.height/28,3*nodeImage.size.width/4,3*nodeImage.size.height/4);
    nodeImageView.backgroundColor = [UIColor greenColor];
    nodeImageView.layer.cornerRadius = nodeImageView.frame.size.width / 2.f;
    nodeImageView.layer.masksToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = view.bounds;
    
    
    //Title Label
    CGRect titleFrame =CGRectMake(43*view.bounds.size.width/100, view.bounds.size.height/4, view.bounds.size.width/2, view.bounds.size.height/4);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:node.name];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    //    titleLabel.textAlignment =  NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Futura" size:40]];
    
    //Position Label
    CGRect posFrame =  CGRectMake(43*view.bounds.size.width/100, view.bounds.size.height/2, view.bounds.size.width/2, view.bounds.size.height/4);
    UILabel *posLabel = [[UILabel alloc] initWithFrame:posFrame];
    
    [posLabel setTextColor:[UIColor blackColor]];
    [posLabel setText:node.position];
    posLabel.adjustsFontSizeToFitWidth = YES;
    //    posLabel.textAlignment =  NSTextAlignmentCenter;
    [posLabel setFont:[UIFont fontWithName:@"Helvetica" size:50]];
    
    [view addSubview:imageView];
    [view addSubview:titleLabel];
    [view addSubview:posLabel];
    [view addSubview:nodeImageView];
    return view;
}

-(id<TreeViewerDelegate>) setup{
    // create nodes
    // add children to parent
    Node *n10=[[Node alloc]initWithIdentifier:@"10" andInfo:@{@"Name":@"Mohamed Hussien",@"ImageName":@"Mohamed_Hussien.jpg",@"Position":@"Designer"}];
    Node *n8=[[Node alloc]initWithIdentifier:@"8" andInfo:@{@"Name":@"Mostafa Zonkoly",@"ImageName":@"Mostafa_Zonkoly.jpg",@"Position":@"iOS Developer"}];
    Node *n9=[[Node alloc]initWithIdentifier:@"9" andInfo:@{@"Name":@"Ahmed Hesham",@"ImageName":@"Ahmed_Hesham.jpg",@"Position":@"Android Developer"}];
    Node *n5=[[Node alloc]initWithChildren:@[n8,n9] andIdentifier:@"5" andInfo:@{@"Name":@"Kareem Ahmed",@"ImageName":@"Kareem_Ahmed.jpg",@"Position":@"Team Leader"}];
    Node *n2=[[Node alloc]initWithChildren:@[n5] andIdentifier:@"2" andInfo:@{@"Name":@"Hossam Saad",@"ImageName":@"Hossam_Saad.jpg",@"Position":@"Co-founder"}];
    Node *n6=[[Node alloc]initWithIdentifier:@"6" andInfo:@{@"Name":@"Amr Assal",@"ImageName":@"Amr_Assal.jpg",@"Position":@"iOS Developer"}];
    Node *n7=[[Node alloc]initWithIdentifier:@"7" andInfo:@{@"Name":@"Hossam Sherif",@"ImageName":@"Hossam_Sherif.jpg",@"Position":@"Senior_iOS Developer"}];
    Node *n4=[[Node alloc]initWithChildren:@[n6,n7,n10] andIdentifier:@"4" andInfo:@{@"Name":@"Mohamed Saad",@"ImageName":@"Mohamed_Saad.jpg",@"Position":@"Co-founder"}];
    Node *n1=[[Node alloc]initWithChildren:@[n2,n4] andIdentifier:@"Ahmed Badie" andInfo:@{@"Name":@"Ahmed Badie",@"ImageName":@"Ahmed_Badie.jpg",@"Position":@"Co-founder & CEO"}];
    
    // add the created view to the node
    n1.nodeView=[self createViewWithNode:n1];
    n2.nodeView=[self createViewWithNode:n2];
    n4.nodeView=[self createViewWithNode:n4];
    n5.nodeView=[self createViewWithNode:n5];
    n6.nodeView=[self createViewWithNode:n6];
    n7.nodeView=[self createViewWithNode:n7];
    n8.nodeView=[self createViewWithNode:n8];
    n9.nodeView=[self createViewWithNode:n9];
    n10.nodeView=[self createViewWithNode:n10];

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

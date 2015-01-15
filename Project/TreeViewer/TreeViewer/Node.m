//
//  Node.m
//  TreeModel
//
//  Created by Ahmed Hesham on 1/1/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#import "Node.h"

@interface Node()

@end

@implementation Node

@synthesize weight=_weight;
@synthesize startX=_startX;
@synthesize identifier=_identifier;
@synthesize children=_children;
@synthesize nodeView=_nodeView;
@synthesize backgroundColor=_backgroundColor;

- (void)viewTapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@"%@",self.identifier);
}

-(UIView *)createView2{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 872,360)];
    view.backgroundColor=[UIColor clearColor];
    UIImage *image;
    if([self.position isEqual:@"Co-founder & CEO"])
        image=[UIImage imageNamed:@"5"];
    else if([self.position isEqual:@"Android Developer"])
        image=[UIImage imageNamed:@"1"];
    else if([self.position isEqual:@"Team Leader"])
        image=[UIImage imageNamed:@"3"];
    else if([self.position isEqual:@"Co-founder"])
        image=[UIImage imageNamed:@"4"];
    else if([self.position isEqual:@"iOS Developer"])
        image=[UIImage imageNamed:@"6"];
    else
//        if([self.position isEqual:@"Senior iOS Developer"])
        image=[UIImage imageNamed:@"2"];
    
    UIImage *nodeImage=[UIImage imageNamed:self.imageName];
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
    [titleLabel setText:self.name];
    titleLabel.adjustsFontSizeToFitWidth = YES;
//    titleLabel.textAlignment =  NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Futura" size:40]];

    //Position Label
    CGRect posFrame =  CGRectMake(43*view.bounds.size.width/100, view.bounds.size.height/2, view.bounds.size.width/2, view.bounds.size.height/4);
    UILabel *posLabel = [[UILabel alloc] initWithFrame:posFrame];
    
    [posLabel setTextColor:[UIColor blackColor]];
    [posLabel setText:self.position];
    posLabel.adjustsFontSizeToFitWidth = YES;
//    posLabel.textAlignment =  NSTextAlignmentCenter;
    [posLabel setFont:[UIFont fontWithName:@"Helvetica" size:50]];

    [view addSubview:imageView];
    [view addSubview:titleLabel];
    [view addSubview:posLabel];
    [view addSubview:nodeImageView];
    return view;
}

-(UIView *)createView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200,80)];
    //rounded corners
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    //background color
    if([self.position isEqual:@"CEO"])
        view.backgroundColor=[UIColor colorWithRed:225.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1];
    else if([self.position isEqual:@"CO"])
        view.backgroundColor=[UIColor colorWithRed:10.0/255.0 green:150.0/255.0 blue:22.0/255.0 alpha:1];
    else if([self.position isEqual:@"Junior"])
        view.backgroundColor=[UIColor colorWithRed:138.0/255.0 green:123.0/255.0 blue:225.0/255.0 alpha:1];
    else if([self.position isEqual:@"Senior"])
        view.backgroundColor=[UIColor colorWithRed:99.0/255.0 green:180.0/255.0 blue:255.0/255.0 alpha:1];
    
    //set border
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 0.5f;
    
    UIImage *image=[UIImage imageNamed:self.imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(view.bounds.origin.x,view.bounds.origin.y, 4*view.bounds.size.width/10, view.bounds.size.height);
//    imageView.contentMode = UIViewContentModeScaleAspectFit;

    //Title Label
    CGRect titleFrame =CGRectMake(4*view.bounds.size.width/10, 4*view.bounds.size.height/10, 6*view.bounds.size.width/10, 6*view.bounds.size.height/10);
    
    UIView *supView=[[UIView alloc]initWithFrame:titleFrame];
    supView.backgroundColor=[UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, titleFrame.size.width, titleFrame.size.height),5,5)];

    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:self.name];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    
    //Position Label
    CGRect posFrame =  CGRectMake(4*view.bounds.size.width/10,0, 6*view.bounds.size.width/10, 4*view.bounds.size.height/10);
    UILabel *posLabel = [[UILabel alloc] initWithFrame:CGRectInset(posFrame,5,5)];
    
    [posLabel setTextColor:[UIColor whiteColor]];
    [posLabel setText:self.position];
    posLabel.adjustsFontSizeToFitWidth = YES;
    posLabel.textAlignment =  NSTextAlignmentCenter;
    
    [supView addSubview:titleLabel];
    
    [view addSubview:posLabel];
    [view addSubview:supView];
    [view addSubview:imageView];

    return view;
}

-(instancetype) initWithIdentifier:(NSString *)identifier andInfo:(NSDictionary *)info{
    self=[super init];
    if(self){
        self.name=[info objectForKey:@"Name"];
        self.imageName=[info objectForKey:@"ImageName"];
        self.position=[info objectForKey:@"Position"];
        
        self.identifier=identifier;
        self.children=[[NSMutableArray alloc]init];
        self.nodeView=[self createView2];
    }
    return self;
}

-(instancetype) initWithChildren:(NSArray *)children andIdentifier:(NSString *) identifier andInfo:(NSDictionary *)info{
    self=[super init];
    if(self){
        self.name=[info objectForKey:@"Name"];
        self.imageName=[info objectForKey:@"ImageName"];
        self.position=[info objectForKey:@"Position"];

        self.identifier=identifier;
        self.children=[[NSMutableArray alloc]initWithCapacity:children.count];
        for(id child in children){
            if([child isKindOfClass:[Node class]])
                [self.children addObject:child];
        }
        self.nodeView=[self createView2];
    }
    return self;
}


@end

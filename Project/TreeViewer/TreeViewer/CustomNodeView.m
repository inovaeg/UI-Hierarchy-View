//
//  CustomNodeView.m
//  TreeViewer
//
//  Created by Ahmed Hesham on 1/21/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#import "CustomNodeView.h"
@interface CustomNodeView ()

@property (strong,nonatomic) IBOutlet UIImageView *nodeImageView;
@property (strong,nonatomic) IBOutlet UIImageView *employeeImageView;
@property (strong,nonatomic) IBOutlet UILabel *titleLabel;
@property (strong,nonatomic) IBOutlet UILabel *positionLabel;

@end

@implementation CustomNodeView

-(void)createViewWithNode :(Node *) node{
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
    self.nodeImageView.image = image;
    
    UIImage *nodeImage=[UIImage imageNamed:node.imageName];
    self.employeeImageView.image =nodeImage;
    
    self.employeeImageView.layer.cornerRadius = self.employeeImageView.frame.size.width / 2.f;
    self.employeeImageView.layer.masksToBounds = YES;
    
    self.titleLabel.text=node.name;
    self.positionLabel.text=node.position;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  HierarchyScrollView.m
//  TreeViewer
//
//  Created by Ahmed Hesham on 1/11/15.
//  Copyright (c) 2015 Inova. All rights reserved.
//

#import "HierarchyScrollView.h"

@interface HierarchyScrollView()<UIScrollViewDelegate>

@property (strong,nonatomic) UIView *treeView;

@end

@implementation HierarchyScrollView

// return the scrollable view.
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.treeView;
}

- (id)initWithFrame:(CGRect)frame andWithRoot:(id<TreeViewerDelegate>)root
{
    // The scroll view that contains the tree.
    self = [super initWithFrame:frame];
    self.backgroundColor=[UIColor whiteColor];

    if (self) {
        self.minimumZoomScale = 0.1;
        self.maximumZoomScale = 2.0;
        self.delegate=self;
        self.contentSize =frame.size;
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapScreen:)];
        tapGesture.numberOfTapsRequired=2;
        [self addGestureRecognizer:tapGesture];

        self.treeView = [[TreeViewer alloc]initWithFrame:frame andWithRoot:root];
        // Set scrollview background to provided background color from the user or with white color as a default color.
        self.treeView.backgroundColor=root.backgroundColor? root.backgroundColor: [UIColor whiteColor];

        [self addSubview:self.treeView];
        
    }
    return self;
}

// Double tapping resize the view.
- (IBAction)TapScreen:(UITapGestureRecognizer *)sender {
    self.zoomScale=0.5;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.zoomScale=0.5;
    self.backgroundColor=[UIColor whiteColor];
}

@end

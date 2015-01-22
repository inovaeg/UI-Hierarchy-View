//
//  TreeViewer.m
//  TreeViewer
//
//  Created by Ahmed Hesham on 12/31/14.
//  Copyright (c) 2014 Inova. All rights reserved.
//

#import "TreeViewer.h"

@interface TreeViewer ()

@property (nonatomic) int numOfNodes;

// return the tree size.
-(CGSize) calculateTreeSize:(id<TreeViewerDelegate>)root;

//recursive method for updating the weights of tree nodes
//the weight value of a node = number of leaf nodes in this subtree.
-(int) updateWeightsForTree:(id<TreeViewerDelegate>)root;

@end

@implementation TreeViewer


static const CGSize gap = {20, 50}; // Gap between cells in rows, also gap between rows
static const CGPoint viewShift ={30, 0}; // tree shift


#pragma mark - tree traversal

// First Path:
// A first dfs path to calculate the starting positions of external leaves.
-(void) dfSearchForNode:(id<TreeViewerDelegate>)root withRowNumber:(int)row withRows:(NSMutableArray *)rowsStart withVisitedArray:(NSMutableArray *)visited{
    // visit and draw node
    int rowWidth=root.weight*(root.nodeView.bounds.size.width+gap.width)-gap.width+(gap.width);
    if(root.children.count == 0)
        [self drawViewWithStartX:root andRowWidth:rowWidth andRowNumber:row];
    
    for(id<TreeViewerDelegate> child in root.children){
        // if the node is starting node in the row then initialize the row with the parents padding.
        if(![visited containsObject:child]){
            if(row+1>rowsStart.count)
                [rowsStart addObject:[NSNumber numberWithInt:root.startX]];
            if(root.startX>[rowsStart[row] intValue]){
                child.startX=root.startX;
                [rowsStart replaceObjectAtIndex:row withObject:[NSNumber numberWithInt:root.startX]];
            }
            else{
                child.startX=[rowsStart[row] intValue];
            }
    
            int rowWidth=child.weight*(child.nodeView.bounds.size.width+gap.width)-gap.width+(gap.width);
            //update row start point
            int rowStartX = [[rowsStart objectAtIndex:row] intValue]+rowWidth;
            [rowsStart replaceObjectAtIndex:row withObject:[NSNumber numberWithInt:rowStartX]];
            //traverse other nodes
            [self dfSearchForNode:child withRowNumber:row+1 withRows:rowsStart withVisitedArray:visited];
            [visited addObject:child];
        }
    }
}

-(void) dfSearchForNode:(id<TreeViewerDelegate>)root withRowNumber:(int)row withRows:(NSMutableArray *)rowsStart{
    // visit and draw node
    int rowWidth=root.weight*(root.nodeView.bounds.size.width+gap.width)-gap.width+(gap.width);
    if(root.children.count == 0)
        [self drawViewWithStartX:root andRowWidth:rowWidth andRowNumber:row];
    
    for(id<TreeViewerDelegate> child in root.children){
        // if the node is starting node in the row then initialize the row with the parents padding.
            if(row+1>rowsStart.count)
                [rowsStart addObject:[NSNumber numberWithInt:root.startX]];
            if(root.startX>[rowsStart[row] intValue]){
                child.startX=root.startX;
                [rowsStart replaceObjectAtIndex:row withObject:[NSNumber numberWithInt:root.startX]];
            }
            else{
                child.startX=[rowsStart[row] intValue];
            }
            
            int rowWidth=child.weight*(child.nodeView.bounds.size.width+gap.width)-gap.width+(gap.width);
            //update row start point
            int rowStartX = [[rowsStart objectAtIndex:row] intValue]+rowWidth;
            [rowsStart replaceObjectAtIndex:row withObject:[NSNumber numberWithInt:rowStartX]];
            //traverse other nodes
            [self dfSearchForNode:child withRowNumber:row+1 withRows:rowsStart];
    }
}



// Second Path:
// A second dfs path to center internal nodes (parent) between it's children.
-(void)postOrderTraverse:(id<TreeViewerDelegate>) node inRow:(int)row{
    if(node){
        for(id<TreeViewerDelegate> child in node.children)
            [self postOrderTraverse:child inRow:row+1];
        // update internal node (parent) position
        if(node.children.count != 0){
            int firstNodeX = ((id<TreeViewerDelegate>)[node.children firstObject]).startX;
            int lastNodeX = ((id<TreeViewerDelegate>)[node.children lastObject]).startX;
            node.startX= firstNodeX+(lastNodeX - firstNodeX)/2;
            NSLog(@"parent start X: %d",node.startX);
            int rowWidth=node.weight*(node.nodeView.bounds.size.width+gap.width)-gap.width+(gap.width);
            [self drawViewWithStartX:node andRowWidth:rowWidth andRowNumber:row];
            NSLog(@"Node # %@: first child start X: %d, last child start X: %d, num of children : %d",node.identifier,firstNodeX,lastNodeX,node.children.count);
        }
        // draw outgoing lines for the node
        [self drawArcFrom:node withLevel:row];
    }
}

// Return number of nodes in the tree.
// BFS traversal for all nodes in the tree to count number of nodes in the tree.
-(int) getNumberOfNodesInTree:(id<TreeViewerDelegate>)root
{
    int count=1;
    NSMutableArray *visited=[[NSMutableArray alloc]init];
    // a queue to insert visited nodes in.
    NSMutableArray *queue=[[NSMutableArray alloc]init];
    [queue addObject:root];
    [visited addObject:root];

    while(queue.count>0){
        id<TreeViewerDelegate> node=[queue objectAtIndex:0];
        [queue removeObjectAtIndex:0];
        for(id child in node.children){
            if(![visited containsObject:child]){
                [queue addObject:child];
                [visited addObject:root];
                count++;
            }
        }
    }
    return count;
}


//return max number in the array
-(int)getMax:(NSMutableArray *)values{
    int max=0;
    for (NSNumber * num in values) {
        if(max<[num intValue])
            max=[num intValue];
    }
    return max;
}

//return the tree height
-(int)getTreeHeight:(id<TreeViewerDelegate>) root{
    if(root.children.count==0)
        return 1;
    NSMutableArray * array=[[NSMutableArray alloc]init];
    for(id<TreeViewerDelegate> child in root.children){
        [array addObject:[[NSNumber alloc]initWithInt: [self getTreeHeight:child]]];
    }
    return [self getMax:array]+1;
}

//return struct that contains width and height of the tree
-(CGSize) calculateTreeSize:(id<TreeViewerDelegate>)root
{
    int levelsNum = [self getTreeHeight:root];
    float width=(root.weight*root.nodeView.bounds.size.width) + ((root.weight+1) * gap.width)+viewShift.x;
    return CGSizeMake(width, ((levelsNum+1)*(gap.height+root.nodeView.bounds.size.height))+viewShift.y);
}

//recursive method for updating the weights of tree nodes
//the weight value of a node = number of leaf nodes in this subtree
-(int) updateWeightsForTree:(id<TreeViewerDelegate>)root{
    if(root.children.count==0){
        root.weight=1;
        return 1;
    }
    for(id child in root.children){
        root.weight += [self updateWeightsForTree:child];
    }
    return root.weight;
}


#pragma mark - drawing tree

-(void) drawArcFrom:(id<TreeViewerDelegate>) node withLevel:(int)row
{
    
    float thickness=3.0;
    //lines color
    int colorHex=0x939598;
    UIColor * color=[UIColor colorWithRed:((float)((colorHex & 0xFF0000) >> 16))/255.0 \
                                    green:((float)((colorHex & 0x00FF00) >>  8))/255.0 \
                                     blue:((float)((colorHex & 0x0000FF) >>  0))/255.0 \
                                    alpha:1.0];
    
    int startX=node.startX+viewShift.x;
    // upper line
    // down from the node
    if(row!=0){
        CGPoint start1 = CGPointMake(startX+node.nodeView.bounds.size.width/2, row*(gap.height+node.nodeView.bounds.size.height) + 1.0 * node.nodeView.bounds.size.height + 0.5*gap.height + viewShift.y);
        CGPoint end1 = CGPointMake(startX+node.nodeView.bounds.size.width/2, row*(gap.height+node.nodeView.bounds.size.height) + 1.0 * node.nodeView.bounds.size.height + 1.0*gap.height + viewShift.y);
        
        UIBezierPath *line1 = [UIBezierPath bezierPath];
        [line1 moveToPoint:start1];
        [line1 addLineToPoint:end1];
        line1.lineWidth=thickness;
        [color setStroke];
        [line1 stroke];
    }
    
    //Lower lines
    //T shape lines
    if(node.children.count!=0){
        //vertical line
        //the vertical lines in the T shape lines
        CGPoint start2 = CGPointMake(startX+node.nodeView.bounds.size.width/2, (row+1)*(gap.height+node.nodeView.bounds.size.height) + 1.0 * node.nodeView.bounds.size.height + viewShift.y);
        CGPoint end2 = CGPointMake(startX+ node.nodeView.bounds.size.width/2, (row+1)*(gap.height+node.nodeView.bounds.size.height) + 1.0 * node.nodeView.bounds.size.height + 0.5*gap.height + viewShift.y);
        
        UIBezierPath *line2 = [UIBezierPath bezierPath];
        [line2 moveToPoint:start2];
        [line2 addLineToPoint:end2];
        line2.lineWidth=thickness;
        [color setStroke];
        [line2 stroke];
        
        int firstChildX = ((id<TreeViewerDelegate>)[node.children firstObject]).startX+viewShift.x+node.nodeView.bounds.size.width/2;
        int lastChildX = ((id<TreeViewerDelegate>)[node.children lastObject]).startX+viewShift.x+node.nodeView.bounds.size.width/2;
        
        // horizontal line
        //the horizontal line in the T shape lines
        CGPoint start3 = CGPointMake(firstChildX, (row+1)*(gap.height+node.nodeView.bounds.size.height) + 1.0 * node.nodeView.bounds.size.height + 0.5*gap.height + viewShift.y);
        CGPoint end3 = CGPointMake(lastChildX, (row+1)*(gap.height+node.nodeView.bounds.size.height) + 1.0 * node.nodeView.bounds.size.height + 0.5*gap.height + viewShift.y);
        
        UIBezierPath *line3 = [UIBezierPath bezierPath];
        [line3 moveToPoint:start3];
        [line3 addLineToPoint:end3];
        line3.lineWidth=thickness;
        [color setStroke];
        [line3 stroke];
    }
}

// add the given view at the pre_calculated position
-(void)drawViewWithStartX:(id<TreeViewerDelegate>)node andRowWidth:(int)rowWidth andRowNumber:(int)row
{
    int startX = node.startX+viewShift.x;
    int startY = (row+1)*(gap.height+node.nodeView.bounds.size.height) + viewShift.y;
    
    //TODO: remove this
    startX-= node.nodeView.bounds.size.width/2;
    startY-= node.nodeView.bounds.size.height/2;
    //
    
    [node.nodeView setFrame:CGRectMake(startX, startY, node.nodeView.bounds.size.width, node.nodeView.bounds.size.height)];
    
    [self addSubview:node.nodeView];
    //add tapgesture to the view in the node
    [self addTapGestureToView:node];
}


//add tapgesture to the view in the node and you should implement the handler in TreeViewerDelegate
-(void) addTapGestureToView:(id<TreeViewerDelegate>)node
{
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:node action:@selector(viewTapped:)];
    [node.nodeView addGestureRecognizer:singleFingerTap];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSMutableArray *visited=[[NSMutableArray alloc]initWithCapacity:self.numOfNodes];
    for (int i=0; i<self.numOfNodes; i++) {
        [visited addObject:@0];
    }
    //two paths for calculating the node start position and size and for drawing the view in the node
    [self dfSearchForNode:self.root withRowNumber:0 withRows:[[NSMutableArray alloc]init]];
    [self postOrderTraverse:self.root inRow:0];
}

#pragma mark - initialization
- (id)initWithFrame:(CGRect)frame andWithRoot:(id<TreeViewerDelegate>)root
{
    int numOfNodes= [self getNumberOfNodesInTree:root];
    self.numOfNodes=numOfNodes;

    [self updateWeightsForTree:root];
    CGSize treeSize = [self calculateTreeSize:root];
    
    self = [super initWithFrame:CGRectMake(0, 0, treeSize.width, treeSize.height)];
    
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.root=root;
    }
    return self;
}




@end

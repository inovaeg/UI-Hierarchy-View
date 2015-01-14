# Hierarchy View

An Objective_C libarary to visalize any hierarchy tree structure.

It supports you with an api to create your tree structure and to add your custom cell views.

##Components

The library components

1. **HierarchyScrollView**
2. **TreeViewer**
3. **TreeViewerDelegate**

Sample code for testing

1. **Node**
2. **TreeViewerViewController**

The **Node** object should adopt the **TreeViewerDelegate** 

The **TreeViewerViewController** should create the tree nodes and initialize **HierarchyScrollView** with the root node.


##Code Example

Our library is used to visalize a tree structure.

So you should create a tree structure of nodes and then initialize our **HierarchyScrollView** with the frame of the view (the frame where you want to show the view) and root node of your tree.

    HierarchyScrollView *view =[[HierarchyScrollView alloc]initWithFrame:self.view.bounds andWithRoot:root];

##Motivation

Consider yourself trying to visualize a supervision hierarchy in a company or any other tree hierarchy, and each node may have multi-children.

Here we can use this libarary, it supports you with a view that visialize the your tree.

You can also add a custom cell view for each node.

![MY_COOL_IMAGE](/Users/inovaEG/Desktop/test.png)

##Installation

To use this project just pull or download it and import it to your project.
You will need the following classes:

1. **HierarchyScrollView**
2. **TreeViewer**
3. **TreeViewerDelegate**


In your ViewController create your tree structure and initialize our **HierarchyScrollView** with the frame of the view *(the frame where you want to show the view)* root node of your tree.

The node object should adopt the `<TreeViewerDelegate>`


##API Reference

The node object should adopt the `<TreeViewerDelegate>`

```
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
```

##Tests

There is a class called **TreeViewerViewController**, here you can test or use our view (*HierarchyScrollView*).

The class contains two methods:

* **-(id <TreeViewerDelegate>) setup;**
* **-(void) viewDidLoad;**

`-(id <TreeViewerDelegate>) setup` method is used to build the tree, create nodes and add children to nodes.

The node object should adopt the `<TreeViewerDelegate>`

`-(void) viewDidLoad` method here you can create our view (*HierarchyScrollView*) and add it to the view controller as subview.

[Vim Repository]: https://github.com/altercation/vim-colors-solarized
##Contributors

We want the hierarchy view to be editable so user can add or remove nodes with animation.



##License

Code and documentation copyright 2015-2020
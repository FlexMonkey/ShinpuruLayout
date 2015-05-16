# ShinpuruLayout
Simple Layout in Swift using HGroups &amp; VGroups

![/ShinpuruLayout/softimage_screen.png](/ShinpuruLayout/softimage_screen.png)

#Introduction

Shinpuru Layout allows developers to layout user interface elements using horizontal and vertical groups. Items in groups can be sized in absolute points or relative percentages and groups may be nested.

#Installation

To install Shinpuru Layout for use in your own project, simply copy SLControls.swift and SLGroup.swift

#Usage

To begin a Shinpuru screen, create a top level container, for horizontal layout:

```let group = SLHGroup()```

...and for vertical layout:

```let group = SLVGroup()```

This top level group needs to be anchored to its superview's bounds:

```
override func viewDidLayoutSubviews()
{
    let top = topLayoutGuide.length
    let bottom = bottomLayoutGuide.length
        
    group.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 10, dy: 10)
}
```

Child elements can be added either though the group's ```children``` array:

```
for i: Int in 1 ... 10
{
  group.children.append(UILabel())
}
```

...or with ```addSubView```:

```
group.addSubview(UILabel())
```

Standard controls will be spaced evenly across the entire width or height of their parent container.

You can subclass ```UIView``` based components and have them implement ```SLLayoutItem``` for more control over sizing. ```SLLayoutItem``` has two properties:

* ```percentageSize``` - defines the percentage width or height of the ```SLLayoutItem```
* ```explicitSize``` - ignored if ```percentageSize``` is not ```nil```, but allows an absolute size in points for the ```SLLayoutItem```

#Animation

![/ShinpuruLayout/AnimatedShinpuru.gif](/ShinpuruLayout/AnimatedShinpuru.gif)

Shinpuru allows for child components to be added and removed with animation. The  [`AddAndRemove`](/ShinpuruLayout/AddAndRemove.swift) class demonstrates this. `SLGroup` supports two methods for animation:

* `addChild(child: UIView, atIndex: Int)` - adds a child at a given index
* `removeChild(#atIndex: Int)` - removes a child at a given index

#Examples

This project ships with six demonstrations:

* [`ComplexGrid`](/ShinpuruLayout/ComplexGrid.swift) - this was the file I used during build and test. The code is a bit messy, but it shows how a ludicrously complex grid can be built from a hierarchy of Shinpuru Layout groups
* [`SoftimageLayout`](/ShinpuruLayout/SoftimageLayout.swift) - a layout inspired by the venerable Softimage
* [`AlignAndDistribute`](/ShinpuruLayout/AlignAndDistribute.swift) - a simple screen demonstrating left, centre and right align, along with evenly distributing components across the width of a container.
* [`DepthOfField`](/ShinpuruLayout/DepthOfField.swift) - my SceneKit depth of field demonstration updated to use Shinpuru for its layout.
* [`CollectionView`](/ShinpuruLayout/CollectionView.swift) - laying out the contents of a ```UICollectionViewCell``` with Shinpuru
* [`AddAndRemove`](/ShinpuruLayout/AddAndRemove.swift) - demonstrates dynamic layout with animation. The screen contains 'Add Row' and 'Remove Row' which add and remove rows at index zero. In turn, each row contains and and remove buttons which add and remove `UIView` instances with a yellow background at index two of the row (indexes zero and one contain the buttons)

#Further Information 

To learn how Shinpuru was build and see examples of different layouts, see my blog:

http://flexmonkey.blogspot.co.uk/2015/05/easy-group-based-layout-for-swift-with.html

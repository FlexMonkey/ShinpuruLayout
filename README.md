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

#Examples

This project ships with five demonstrations:

* ```ComplexGrid``` - this was the file I used during build and test. The code is a bit messy, but it shows how a ludicrously complex grid can be built from a hierarchy of Shinpuru Layout groups
* ```SoftimageLayout``` - a layout inspired by the venerable Softimage
* ```AlignAndDistribute``` - a simple screen demonstrating left, centre and right align, along with evenly distributing components across the width of a container.
* ```DepthOfField``` - my SceneKit depth of field demonstration updated to use Shinpuru for its layout.
* ```CollectionView``` - laying out the contents of a ```UICollectionViewCell``` with Shinpuru

#Further Information 

To learn how Shinpuru was build and see examples of different layouts, see my blog:

http://flexmonkey.blogspot.co.uk/2015/05/easy-group-based-layout-for-swift-with.html

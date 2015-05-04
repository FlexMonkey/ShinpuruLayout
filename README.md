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

#Further Information 

http://flexmonkey.blogspot.co.uk/2015/05/easy-group-based-layout-for-swift-with.html

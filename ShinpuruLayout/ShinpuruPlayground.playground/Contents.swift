//: Shinpuru Layout

import UIKit

let hGroup = SLHGroup()
hGroup.frame = CGRect(x: 0, y: 0, width: 400, height: 100)
hGroup.margin = 5
hGroup.backgroundColor = UIColor.yellowColor()

hGroup

let leftVGroup = SLVGroup()
leftVGroup.backgroundColor = UIColor.blueColor()

let rightVGroup = SLVGroup()
rightVGroup.backgroundColor = UIColor.purpleColor()

hGroup.children = [leftVGroup, rightVGroup]

hGroup

leftVGroup.percentageSize = 25
rightVGroup.percentageSize = 75

hGroup.children = [leftVGroup, rightVGroup]

let leftTopGroup = SLHGroup()
let leftBottomGroup = SLHGroup()

leftTopGroup.backgroundColor = UIColor.lightGrayColor()
leftBottomGroup.backgroundColor = UIColor.lightGrayColor()

leftVGroup.margin  = 5

leftVGroup.children = [leftTopGroup, leftBottomGroup]

hGroup.children = [leftVGroup, rightVGroup]

hGroup



//
//  SLControls.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 03/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class SLLabel: UILabel, SLLayoutItem
{
    var percentage: CGFloat = 0
}

/// SLLayoutItem
protocol SLLayoutItem
{
    /// For items in an HGroup, the width as a percentage of the parent's width, for items in a VGroup, the height as a percentage of the parent's height
    var percentage: CGFloat {get set}
}
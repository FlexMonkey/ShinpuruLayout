//
//  SLControls.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 03/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>

import UIKit

class SLLabel: UILabel, SLLayoutItem
{
    var percentageSize: CGFloat?
    var explicitSize: CGFloat?
}

class SLButton: UIButton, SLLayoutItem
{
    var percentageSize: CGFloat?
    var explicitSize: CGFloat?
}

class SLSpacer: UIView, SLLayoutItem
{
    var percentageSize: CGFloat?
    var explicitSize: CGFloat?
    
    required init(percentageSize: CGFloat?, explicitSize: CGFloat?)
    {
        super.init(frame: CGRectZero)
        
        self.percentageSize = percentageSize
        self.explicitSize = explicitSize
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}

/// SLLayoutItem
protocol SLLayoutItem
{
    /// For items in an HGroup, the width as a percentage of the parent's width, for items in a VGroup, the height as a percentage of the parent's height
    /// If set to nil, Shinpuru Layout treats this like a standard UIView and automatically sets percentage itself
    var percentageSize: CGFloat? {get set}
    
    /// If percentage is nil, optional explicit size allows the item's width or height to be set in points
    var explicitSize: CGFloat? {get set}
}
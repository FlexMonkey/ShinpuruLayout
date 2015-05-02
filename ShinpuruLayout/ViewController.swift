//
//  ViewController.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 02/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let hGroupA = SLHGroup()
    let hGroupB = SLHGroup()
    
    let vGroup = SLVGroup()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for i: Int in 1 ... 10
        {
            let btn = UIButton()
            btn.backgroundColor = UIColor.grayColor()
            btn.setTitle("A: \(i)", forState: UIControlState.Normal)
            
            hGroupA.children.append(btn)
        }
        
        
        
        for i: Int in 1 ... 5
        {
            let btn = UIButton()
            btn.backgroundColor = UIColor.grayColor()
            btn.setTitle("B: \(i)", forState: UIControlState.Normal)
            
            hGroupB.children.append(btn)
        }
        
        hGroupA.margin = 1
        hGroupB.margin = 1
        vGroup.margin = 1
        
        vGroup.children = [hGroupA, hGroupB]
        
        view.addSubview(vGroup)
    }

    override func viewDidLayoutSubviews()
    {
        vGroup.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 60)
    }
}


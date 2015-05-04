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
    let hGroupC = SLHGroup()
    let hGroupD = SLHGroup()
    let hGroupE = SLHGroup()
    let hGroupF = SLHGroup()
    let hGroupG = SLHGroup()
    
    let vGroup = SLVGroup()
    
    // For this demo, UILabels are orange
    func createUILabel(text: String) -> UILabel
    {
        let label = UILabel()
        label.layer.backgroundColor = UIColor.orangeColor().CGColor
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        
        return label
    }
    
    // For this demo, SLLabels are purple
    func createSLLabel(text: String, percentageSize: CGFloat?, explicitSize: CGFloat? = nil) -> SLLabel
    {
        let label = SLLabel()
        label.layer.backgroundColor = UIColor.purpleColor().CGColor
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        label.textColor = UIColor.whiteColor()
        label.percentageSize = percentageSize
        label.explicitSize = explicitSize
        return label
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // a...
        for i: Int in 1 ... 10
        {
            hGroupA.children.append(createUILabel("idx: \(i)"))
        }

        // b...
        hGroupB.children.append(createSLLabel("auto %", percentageSize: nil))
        for i: Int in [15, 20, 40, 10]
        {
            hGroupB.children.append(createSLLabel("\(i)%", percentageSize: CGFloat(i)))
        }

        // c...
        for i: Int in [20, 15]
        {
            hGroupC.children.append(createSLLabel("\(i)%", percentageSize: CGFloat(i)))
        }
        for i: Int in 1 ... 3
        {
            hGroupC.children.append(createUILabel("idx: \(i)"))
        }
        for i: Int in [25]
        {
            hGroupC.children.append(createSLLabel("\(i)%", percentageSize: CGFloat(i)))
        }
        
        // d...
        for i: Int in 1 ... 4
        {
            hGroupD.children.append(createUILabel("idx: \(i)"))
        }
        hGroupD.children.insert(createSLLabel("auto %", percentageSize: nil), atIndex: 2)
        hGroupD.children.insert(createSLLabel("auto %", percentageSize: nil), atIndex: 4)
        
        // e...
        hGroupE.addSubview(createSLLabel("100pt", percentageSize: nil, explicitSize: 100))
        hGroupE.addSubview(createUILabel("auto %"))
        hGroupE.addSubview(createSLLabel("200pt", percentageSize: nil, explicitSize: 200))
        
        // f...
        hGroupF.addSubview(createSLLabel("250pt", percentageSize: nil, explicitSize: 250))
        hGroupF.addSubview(createSLLabel("33%", percentageSize: 33))
        hGroupF.addSubview(createUILabel("auto %"))
        hGroupF.addSubview(createSLLabel("75pt", percentageSize: nil, explicitSize: 75))
        
        // g...
        hGroupG.addSubview(createSLLabel("200pt", percentageSize: nil, explicitSize: 200))
        let vGroupA = SLVGroup()
        let hGroupGA = SLHGroup()
        hGroupGA.children = [createSLLabel("100pt", percentageSize: nil, explicitSize: 100), createUILabel("auto %"), createSLLabel("auto %", percentageSize: nil)]
        vGroupA.children = [createUILabel("auto %"), hGroupGA]
        vGroupA.addSubview(createSLLabel("25pt", percentageSize: nil, explicitSize: 25))
        hGroupG.addSubview(vGroupA)
        
        hGroupA.percentageSize = 20
        hGroupB.percentageSize = nil
        hGroupC.percentageSize = 30
        hGroupD.percentageSize = 15
        hGroupE.explicitSize = 150
        hGroupG.explicitSize = 200
        
        vGroup.children = [hGroupA, hGroupB, hGroupC, hGroupD, hGroupE, hGroupF, hGroupG]
        
        view.addSubview(vGroup)
    }

    override func viewDidLayoutSubviews()
    {
        vGroup.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height).rectByInsetting(dx: 50, dy: 50)
    }
}


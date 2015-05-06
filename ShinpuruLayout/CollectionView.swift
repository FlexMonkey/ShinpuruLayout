//
//  CollectionView
//  ShinpuruLayout
//
//  Created by Simon Gladman on 06/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    var collectionView: UICollectionView!
    var colors = [Color]()
    
    override func viewDidLoad()
    {
        for _ in 0...250
        {
            colors.append(Color())
        }
        
        super.viewDidLoad()
 
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: 200, height: 150)
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.registerClass(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return colors.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ColorCollectionViewCell
        
        cell.color = colors[indexPath.item]

        return cell
    }
    
    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        collectionView.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 10, dy: 10)
    }
}

class ColorCollectionViewCell: UICollectionViewCell
{
    var mainGroup = SLHGroup()
    let swatch = UIView()
    let mainLabel = UILabel()
    let redLabel = UILabel()
    let greenLabel = UILabel()
    let blueLabel = UILabel()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)

        let labelsVGroup = SLVGroup()
        labelsVGroup.children = [redLabel, greenLabel, blueLabel]
        
        mainGroup.children = [swatch, labelsVGroup]
        mainGroup.margin = 2
        
        mainGroup.frame = contentView.bounds.rectByInsetting(dx: 5, dy: 5)
        
        contentView.layer.borderColor = UIColor.blueColor().CGColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 5
        
        swatch.layer.cornerRadius = 5
        
        contentView.addSubview(mainGroup)
    }

    var color: Color?
    {
        didSet
        {
            swatch.backgroundColor = color?.color
            mainLabel.text = "Color"
            
            if let color = color
            {
                redLabel.text = NSString(format: "Red: %02X", Int(color.red * 255)) as String
                greenLabel.text = NSString(format: "Green: %02X", Int(color.green * 255)) as String
                blueLabel.text = NSString(format: "Blue: %02X", Int(color.blue * 255)) as String
            }
        }
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Color
{
    let color: UIColor
    
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    
    init()
    {
        red = CGFloat(drand48())
        green = CGFloat(drand48())
        blue = CGFloat(drand48())
        
        color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
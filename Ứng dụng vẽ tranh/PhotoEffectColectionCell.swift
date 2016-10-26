//
//  PhotoEffectColectionCell.swift
//  Ứng dụng vẽ tranh
//
//  Created by PIRATE on 10/26/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class PhotoEffectColectionCell: UICollectionViewCell {
    let kCellWidth: CGFloat = 44
    var filteredImageView : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        addSubview()
    }
    
    func addSubview() {
        if (filteredImageView == nil){
            filteredImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kCellWidth, height: kCellWidth))
            filteredImageView.layer.borderColor = tintColor.cgColor
            contentView.addSubview(filteredImageView)
        }
    }
    override var isSelected: Bool
        {
        didSet
        {
            filteredImageView.layer.borderWidth = isSelected ? 2 : 0
        }
    }

}

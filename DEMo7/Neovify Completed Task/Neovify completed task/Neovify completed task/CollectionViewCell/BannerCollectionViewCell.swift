//
//  BannerCollectionViewCell.swift
//  Neovify completed task
//
//  Created by Saumil Doshi on 04/11/24.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //contentView.backgroundColor = UIColor(red: -0/255, green: 39/255, blue: 75/255, alpha: 1)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = false
    }

}

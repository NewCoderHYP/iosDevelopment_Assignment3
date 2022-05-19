//
//  DetailsCollectionReusableView.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 16/05/2022.
//

import UIKit

class DetailsCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

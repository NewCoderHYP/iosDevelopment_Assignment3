//
//  BookingOrderCell.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 17/05/2022.
//

import UIKit

class BookingOrderCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var cancelBlock:(() -> ())?
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var seatLabel: UILabel!
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.cancelBlock?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

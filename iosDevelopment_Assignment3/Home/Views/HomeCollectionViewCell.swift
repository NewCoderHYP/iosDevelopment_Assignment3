//
//  HomeViewController.swift
//  HomeCollectionViewCell
//
//  Created by Yinpeng on 12/05/2022.
//

import UIKit

typealias CollectRequestBlock = (_ isCollect:Int)->Void;

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    private var homeListModel: HomeListModel?

    var block : CollectRequestBlock?;

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
    }
    
    @IBAction func exchangeAction(_ sender: Any) {
       
    }
    
    func config(homeListModel: HomeListModel?) {
        guard let homeListModel = homeListModel else { return }
        self.homeListModel = homeListModel
        titleLabel.text = homeListModel.name
        introductionLabel.text = homeListModel.introduction
        distanceLabel.text = homeListModel.distance

        imageView.image = UIImage(named: homeListModel.image!)
       
    }
    
}


/// ======================== Request =========================

struct FavouriteBody: Codable {
    var activityId: Int?
}

struct FavouriteDeleteBody: Codable {
    var collectId: Int?
}

extension HomeCollectionViewCell {
    
    

}

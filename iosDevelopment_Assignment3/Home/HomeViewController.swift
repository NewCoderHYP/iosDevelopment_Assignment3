//
//  HomeViewController.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 10/05/2022.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    private var homeList = [HomeListModel]()
    private var homeVM = HomeViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHomeList()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        // Do any additional setup after loading the view.
        configUI()
    }

    private func configUI() {
        layout?.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout?.minimumLineSpacing    = 10
        layout?.minimumInteritemSpacing = 10
        let width = (UIScreen.main.bounds.size.width - 30)/2
        let height: CGFloat = 55 + (UIScreen.main.bounds.size.width - 30) * 0.5
        layout.itemSize = .init(width: width, height: height)
        collectionView.collectionViewLayout = layout
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor  = UIColor.init(red: 247 / 255, green: 247 / 255, blue: 250 / 255, alpha: 1.0)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.register(UINib(nibName: "HomeCollectionViewCell", bundle: Bundle(for: HomeCollectionViewCell.self)), forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
}

extension HomeViewController {
    @objc func loadHomeList() {
        let data = homeVM.restaurantList
        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
            
            if let info = try? JSONDecoder().decode(HomeListResponse.self, from: jsonData ?? Data()) {
                
                self.homeList = (info.list ?? [])
            }
        
        self.collectionView?.reloadData()
    }
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    /// =========== UICollectionViewDelegate ===========
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeListModel = homeList[indexPath.row]
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.config(homeListModel: homeListModel)
        cell.block = {(isCollect:Int) in
            self.collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = DetailsViewController()
        details.homeListModel = self.homeList[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
    }


}


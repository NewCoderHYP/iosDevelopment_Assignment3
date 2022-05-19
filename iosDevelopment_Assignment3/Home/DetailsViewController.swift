//
//  DetailsViewController.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 16/05/2022.
//

import UIKit

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var homeListModel = HomeListModel()
    private var homeVM = HomeViewModel()
    
    var hasBookingSeatModels: [SeatModel] = []

    var hasBookingSeat: [String] = []

    var seletedSeat = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        // Do any additional setup after loading the view.
        
        do {
            hasBookingSeatModels = try DataStorageManager.readSeatModels()
            for model in hasBookingSeatModels {
                if model.restaurantId == homeListModel.restaurantId && homeListModel.seats!.contains(model.seat!){
                    hasBookingSeat.append(model.seat!)
                }
            }
            
            self.collectionView.reloadData()
        } catch {
        }
        
        configUI()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "booking", style: UIBarButtonItem.Style.done, target: self, action: #selector(booking))
        
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }

   @objc func booking() {
       if seletedSeat != "" {
           let seatModel = SeatModel(restaurantId: homeListModel.restaurantId, name: homeListModel.name, image: homeListModel.image, seat: seletedSeat)
           hasBookingSeatModels.append(seatModel)
           
           do {
               try DataStorageManager.storeSeat(seats: hasBookingSeatModels)
               self.navigationController?.popViewController(animated: true)
               
           } catch {
           }
           
       }
    }
    
    private func configUI() {
        layout?.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout?.minimumLineSpacing    = 10
        layout?.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 280)
        let width = (UIScreen.main.bounds.size.width - 30)/2
        let height: CGFloat = (UIScreen.main.bounds.size.width - 30) * 0.5
        layout.itemSize = .init(width: width, height: height)
        collectionView.collectionViewLayout = layout
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor  =  UIColor.init(red: 247 / 255, green: 247 / 255, blue: 250 / 255, alpha: 1.0)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.register(UINib(nibName: "SeatCollectionViewCell", bundle: Bundle(for: SeatCollectionViewCell.self)), forCellWithReuseIdentifier: "SeatCollectionViewCell")
        collectionView.register(UINib(nibName: "DetailsCollectionReusableView", bundle: Bundle(for: DetailsCollectionReusableView.self)), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailsCollectionReusableView")
    }
}

extension DetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    /// =========== UICollectionViewDelegate ===========
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeListModel.seats?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let seat = homeListModel.seats?[indexPath.row]
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as! SeatCollectionViewCell
        cell.indexLabel.text = "\(indexPath.item + 1)"
        let showMark = (seat == seletedSeat || hasBookingSeat.contains(seat!))
        cell.markImageView.isHidden = !showMark
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let seat = homeListModel.seats?[indexPath.row]

        if !hasBookingSeat.contains(seat!) {
            seletedSeat = seat!
        }
        
        self.collectionView.reloadData()
    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         if kind == UICollectionView.elementKindSectionHeader {
             let header:DetailsCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DetailsCollectionReusableView", for: indexPath) as! DetailsCollectionReusableView
             header.imageView.image = UIImage(named: self.homeListModel.image!)
             header.titleLabel.text = self.homeListModel.name
             header.contentLabel.text = self.homeListModel.introduction
             header.addressLabel.text = self.homeListModel.distance
             return header
         }
         return UICollectionReusableView()
     }
     

}


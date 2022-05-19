//
//  BookingOrderViewController.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 10/05/2022.
//

import UIKit

class BookingOrderViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var hasBookingSeatModels: [SeatModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Order"
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "BookingOrderCell", bundle: Bundle(for: BookingOrderCell.self)), forCellReuseIdentifier: "BookingOrderCell")

    }
    
    func refreshData() {
        do {
            hasBookingSeatModels = try DataStorageManager.readSeatModels()
            tableView.reloadData()
        } catch {
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return hasBookingSeatModels.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 5))
        footer.backgroundColor = UIColor.init(red: 248 / 255, green: 249 / 255, blue: 252 / 255, alpha: 1.0)
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingOrderCell", for: indexPath) as! BookingOrderCell
       
        
        let seatModel = hasBookingSeatModels[indexPath.section]
        
        cell.imgView.image = UIImage.init(named: seatModel.image!)
        cell.nameLabel.text = seatModel.name
        cell.seatLabel.text = String(format: "Table number：%@", seatModel.seat!)
        cell.cancelBlock = {
            self.hasBookingSeatModels.remove(at: indexPath.section)
            do {
                try DataStorageManager.storeSeat(seats: self.hasBookingSeatModels)
                self.tableView.reloadData()
            } catch {
            }
        }
        cell.selectionStyle = .none
        return cell
    }
}

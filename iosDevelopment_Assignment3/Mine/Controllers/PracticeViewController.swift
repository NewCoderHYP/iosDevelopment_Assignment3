//
//  PracticeViewController.swift
//  Teaching
//
//  Created by McCormick on 2022/2/25.
//

import UIKit

import UIKit
import Kingfisher
import ZKProgressHUD

class PracticeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var courseList = [PracticeRecordModel]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCourseList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "练习记录"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FBMeBaseCell.self, forCellReuseIdentifier: FBMeBaseCell.identifier)
        tableView.tableFooterView = UIView()
        EmptyView.show(inView: tableView)?.backgroundColor(.hex("#f7f7f7"))

    }


     // MARK: UITableViewDataSource
        // cell的个数
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.courseList.count
        }
        
        // UITableViewCell
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cellid = "testCellID"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
            if cell==nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
            }
            let courseModel = self.courseList[indexPath.row]
            cell?.textLabel?.text = courseModel.practiceTitle
            cell?.detailTextLabel?.numberOfLines = 3
            cell?.detailTextLabel?.text = String(format: "\n正确答案：%@  回答：%@  状态：%@",courseModel.practiceAnswercorrect ?? "", courseModel.practiceAnswer ?? "",courseModel.answerType == 1 ? "回答正确" : "回答错误")
            cell?.detailTextLabel?.textColor = .gray
        
            return cell!
        }
      

        // 选中cell后执行此方法
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(indexPath.row)
        }

}

/// ======================== Request =========================

extension PracticeViewController {
    /// =========== Request ===========
    /// 列表
    private func loadCourseList() {
        EmptyView.remove(inView: tableView)
        NetWorkTool.requestData(.post, API: .practiceRecordInfoView, bodyData: Body().toJSONData()) { [weak self] result, errMsg in
            if let data = result as? [String: Any] {
                let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
                
                if let info = try? JSONDecoder().decode(PracticeRecordListResponse.self, from: jsonData ?? Data()) {
                    
                    self?.courseList = (info.data ?? [])
                }
            }
            
           
            self?.tableView?.reloadData()
            if IsCollectionEmpty(self?.courseList) {
                EmptyView.show(inView: self?.tableView)?.backgroundColor(.hex("#f7f7f7"))
            } else {
                EmptyView.remove(inView: self?.tableView)
            }
            
            if !IsCollectionEmpty(errMsg) {
                ZKProgressHUD.showMessage(errMsg)
            }
        }
    }
    

}

//
//  PayPalViewController.swift
//  RaoViet
//
//  Created by Chung on 1/3/17.
//  Copyright © 2017 3i. All rights reserved.
//

import UIKit

class PayPalViewController: BaseViewController {
    
    @IBOutlet weak var lbTotal: UILabel!
    
    @IBOutlet weak var table_buy: UITableView!
    
    var data: [Credit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivity()
        print("aa \(self.user.id)")
        getTotalCredit(user_id: self.user.id)
        getAllCreditExchange()
    }
    
    func configSubView() {
        table_buy.delegate = self
        table_buy.dataSource = self
        table_buy.register(  UINib(nibName: "CellForBuyCredit", bundle: nil), forCellReuseIdentifier: "CreditExchange")
    }
    
    
    func getTotalCredit(user_id: String) {
        self.showActivity(isShow: true)
        ManagerData.instance.getTotalCredit(user_id: user_id, success: { [unowned self] count in
            self.showActivity(isShow: false)
            self.lbTotal.text = "Tổng credit: \(count)"
            }, fail: { msg in
                self.showAlert(msg: msg)
        })
    }
    func getAllCreditExchange() {
        ManagerData.instance.getAllCreditExchange( success: { (json, msg) in
            if (json?.array?.count)! > 0 {
                for item in (json?.array)! {
                    self.data.append(Credit(from: item))
                }
                self.showActivity(isShow: false)
                DispatchQueue.main.async {
                    self.table_buy.reloadData()
                }
                
            }else{
                self.showActivity(isShow: false)
            }
        }, fail: { msg in
            self.showActivity(isShow: false)
            
        })
        
    }
    
    
    
    @IBAction func actionShowHistory(_ sender: UIButton) {
    }
}
extension PayPalViewController : UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


extension PayPalViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditExchange") as! CellForBuyCredit
        if let item: Credit = data[indexPath.row] {
            cell.lbTitle.text = "\(item.num_of_credit) (credit)"
            cell.lbPrice.text = "\(item.num_monney) $"
        }
        return cell
    }
    
}



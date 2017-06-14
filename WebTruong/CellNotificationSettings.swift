//
//  CellNotificationSettings.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/1/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class CellNotificationSettings: UITableViewCell {

    @IBOutlet weak var switchNotification: UISwitch!
    @IBOutlet weak var lableName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var setupNotification : NotificationSettings? {
        
        didSet{
            lableName.text = setupNotification?.titleName
            if let turn_onoff = setupNotification?.switchCheck {
                switchNotification.isOn = turn_onoff
            }
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    @IBAction func handelSwichNotification(_ sender: UISwitch) {
        
        if sender.isOn {
            print("Check")
        }else{
            print("UnCheck")
        }
        
    }
}

//
//  PersonTableViewCell.swift
//  TableView&TableField
//
//  Created by student on 2018/11/10.
//  Copyright © 2018年 yx. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var picture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

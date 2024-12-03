//
//  ListVCTableViewCell.swift
//  Execellent_web_world_practice_task
//
//  Created by Saumil Doshi on 23/11/24.
//

import UIKit

class ListVCTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFullName: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblAge: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblBirthday: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

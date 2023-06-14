//
//  UsersTableViewCell.swift
//  testMessager
//
//  Created by Mikhail Chudaev on 30.05.2023.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    static let reuseId = "UsersTableViewCell"
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(_ name: String) {
        userName.text = name
        settingsCell()
    }
    
    func settingsCell() {
        parentView.layer.cornerRadius = 20
        userImage.layer.cornerRadius = userImage.frame.width/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

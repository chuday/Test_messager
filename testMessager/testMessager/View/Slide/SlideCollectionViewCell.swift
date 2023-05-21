//
//  SlideCollectionViewCell.swift
//  testMessager
//
//  Created by Mikhail Chudaev on 18.05.2023.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var slideImage: UIImageView!
    
    @IBOutlet weak var registButton: UIButton!
    @IBOutlet weak var authButton: UIButton!
    
    static let reuseId = "SlideCollectionViewCell"
    
    var delegate: LoginViewControllerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(slide: Slides) {
        
        if slide.id == 3 {
            registButton.isHidden = false
            authButton.isHidden = false
        }
        
        slideImage.image = slide.image
        descriptionText.text = slide.text
    }
    
    @IBAction func regBitton(_ sender: Any) {
        delegate.openRegVC()
    }
    
    @IBAction func authButton(_ sender: Any) {
        delegate.openAuthVC()
    }
    
}

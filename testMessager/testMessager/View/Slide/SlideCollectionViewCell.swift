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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        
    }
    
    @IBAction func authButton(_ sender: Any) {
        
    }
    
}

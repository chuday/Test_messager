//
//  SliderSlides.swift
//  testMessager
//
//  Created by Mikhail Chudaev on 19.05.2023.
//

import Foundation
import UIKit

class SliderSlides {
    
    func getSlides() -> [Slides] {
        var slides: [Slides] = []
        
        let slidesFirst = Slides(id: 1, text: "text 1", image: UIImage(named: "one")!)
        let slidesSecond = Slides(id: 2, text: "text 2", image: UIImage(named: "two")!)
        let slidesThird = Slides(id: 3, text: "text 3", image: UIImage(named: "three")!)
        
        slides.append(slidesFirst)
        slides.append(slidesSecond)
        slides.append(slidesThird)
        
        return slides
    }
}

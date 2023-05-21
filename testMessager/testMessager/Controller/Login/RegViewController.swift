//
//  RegViewController.swift
//  testMessager
//
//  Created by Mikhail Chudaev on 19.05.2023.
//

import UIKit

class RegViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
}

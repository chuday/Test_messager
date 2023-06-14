//
//  RegViewController.swift
//  testMessager
//
//  Created by Mikhail Chudaev on 19.05.2023.
//

import UIKit

class RegViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var tapGest: UITapGestureRecognizer?
    var service = Service.shared
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordAgainField: UITextField!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passAgainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditingGuest))
        mainView.addGestureRecognizer(tapGest!)
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @objc func endEditingGuest() {
        self.view.endEditing(true)
    }
    
    @IBAction func regButton(_ sender: Any) {
        
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField) {
            
            if passwordField.text == passwordAgainField.text {
                
                service.createNewUser(LoginField(email: emailField.text!, password: passwordField.text!)) { [weak self] code in
                    switch code.code {
                    case 0:
                        print("error")
                    case 1:
                        print("success")
                        self?.service.confirmEmail()
                        let alert = UIAlertController(title: "Ok", message: "Success", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "Good", style: .default) { _ in
                            self?.delegate.closeVC()
                        }
                        alert.addAction(okButton)
                        self?.present(alert, animated: true)
                        
                    default:
                        print("default")
                    }
                }
                print("is correct")
            } else {
                print("not correct")
            }
        }
    }
}

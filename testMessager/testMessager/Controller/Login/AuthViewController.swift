//
//  AuthViewController.swift
//  testMessager
//
//  Created by Mikhail Chudaev on 19.05.2023.
//

import UIKit
import Foundation

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var mainView: UIView!
    
    var delegate: LoginViewControllerDelegate!
    var service = Service.shared
    var tapGest: UITapGestureRecognizer?
    var checkField = CheckField.shared
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func authButton(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField) {
            let authData = LoginField(email: emailField.text!, password: passwordField.text!)
            service.authInApp(authData) { [weak self] responce in
                switch responce {
                    
                case .success:
                    print("next")
                    self?.userDefaults.set(true, forKey: "isLogin")
                    self?.delegate.startApp()
                    self?.delegate.closeVC()

                case .noVerify:
                    let alert = self?.alertAction("Error", "Not verify email")
                    let verifyButton = UIAlertAction(title: "Ok", style: .default)
                    alert?.addAction(verifyButton)
                    self?.present(alert!, animated: true)
                    
                case .error:
                    let alert = self?.alertAction("Error", "Email or password incorrect")
                    let verifyButton = UIAlertAction(title: "Ok", style: .default)
                    alert?.addAction(verifyButton)
                    self?.present(alert!, animated: true)
                }
            }
        } else {
            let alert = self.alertAction("Error", "Check login and button")
            let verifyButton = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(verifyButton)
            self.present(alert, animated: true)
        }
    }
    
    func alertAction(_ header: String?, _ message: String?) -> UIAlertController {
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @IBAction func forgotButton(_ sender: Any) {
    }
    
    @IBAction func haveAccount(_ sender: Any) {
    }
    
}

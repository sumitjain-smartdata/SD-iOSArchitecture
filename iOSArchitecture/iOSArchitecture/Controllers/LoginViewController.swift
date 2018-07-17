//
//  ViewController.swift
//  iOSArchitecture
//
//  Created by Amit on 23/02/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewControler {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginAction(_ sender: Any) {
        if let email = self.emailTextField.text,let password = self.passwordTextField.text, !email.isEmpty && !password.isEmpty {
            let service = UserService()
            service.doLogin(with: email, password: password, target: self, complition: { (response) in
                DispatchQueue.main.async {
                    if let user = response {
                        AppInstance.shared.user = user
                        let storyboard = UIStoryboard(name: Identifiers.Storyboard.Main, bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: Identifiers.Controller.Home) as! HomeViewController
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    
                }
            })
        } else {
            self.showAlert(with: "All fields are mandatory.")
        }
           
    }
    
}


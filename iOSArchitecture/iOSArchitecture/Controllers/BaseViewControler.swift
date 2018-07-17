//
//  BaseViewControler.swift
//  iOSArchitecture
//
//  Created by Amit on 24/02/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import Foundation
import UIKit
import SwiftLoader

class BaseViewControler: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    // #Helper functions
    func showLoader() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideLoader() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func showAlert(with message:String) {
        AlertManager.showOKAlert(withTitle: nil, withMessage: message, onViewController: self).view.tintColor = self.view.tintColor
    }
}

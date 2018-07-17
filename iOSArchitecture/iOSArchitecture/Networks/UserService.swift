//
//  LoginAPIManager.swift
//  iOSArchitecture
//
//  Created by Amit on 23/02/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import Foundation
import UIKit

public class UserService:APIService {
    
    // #show and hide loader in this class depending on your needs.
    // #you can make service class according to module
    // #show errors in this class, if you have any need where you want to show in controller class, then just by-pass error method.
    func doLogin(with email:String,password:String,target:BaseViewControler? = nil, complition:@escaping (User?) -> Void){
        let param = ["username":email,"password":password]
        
        target?.showLoader()
        
        super.startService(with: .POST, path: Config.login, parameters: param,files: []) { (result) in
            
            DispatchQueue.main.async {
                
                target?.hideLoader()
                
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let data = response as? Dictionary<String,Any> {
                        let user = User(dictionary: data)
                        complition(user)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    // #display error message here
                    target?.showAlert(with: error)
                    complition(nil)
                }
            }
        }
        
    }
}


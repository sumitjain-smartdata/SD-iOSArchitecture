//
//  Constant.swift
//  iOSArchitecture
//
//  Created by Amit Shukla on 05/07/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import Foundation

enum Config {
    
    // Copy base url here
    static let baseUrl = "http://192.155.246.146:9224/webservice/"
    
    // All end points will be here
    static let login = "profiles/staff_login"
    
}

enum Identifiers {
    
    enum Storyboard {
        static let Main = "Main"
    }
    
    enum Controller {
        static let Home  = "Home"
        static let Login = "Login"
        static let Registration = "Registration"
    }
    
}

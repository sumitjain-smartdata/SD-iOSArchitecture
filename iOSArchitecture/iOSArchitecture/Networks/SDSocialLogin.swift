//
//  SocialLogin.swift
//  Catalog-App
//
//  Created by Sumit Jain on 03/11/15.
//  Copyright © 2015 Sumit Jain. All rights reserved.
//

import UIKit
//import FBSDKLoginKit
//import GoogleSignIn

/*public typealias GoogleLoginResponse = (GIDGoogleUser?, NSError?) -> Void
public typealias FBLoginResponse = ([NSObject : AnyObject]?, NSError?) -> Void

public class SocialLogin: NSObject, GIDSignInDelegate, GIDSignInUIDelegate {
    private var _googleResponseHandler: GoogleLoginResponse?
    
    private static var _sInstance : SocialLogin!
    
    public class func getInstance() -> SocialLogin {
        if(_sInstance == nil) {
            _sInstance = SocialLogin()
        }
        
        return _sInstance
    }

    public class func loginWithGoogleWithCallBackResponse(completionHandler: @escaping GoogleLoginResponse) {
        let socialLogin = SocialLogin.getInstance()
        socialLogin._googleResponseHandler = completionHandler
        
        let signIn = GIDSignIn.sharedInstance()
//        signIn?.clientID = ApplicationConstants.googleClientID()
        signIn?.shouldFetchBasicProfile = true
//        signIn?.scopes = [FXWebRequestURL.getGooglePlusAuthURL()]
        signIn?.delegate = socialLogin
        signIn?.uiDelegate = socialLogin
        signIn?.signIn()
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if _googleResponseHandler != nil {
            _googleResponseHandler!(user, error as NSError?)
        }
    }

    public class func loginWithFacebookAtViewController(vc: UIViewController!, completionHandler: FBLoginResponse) {
        if vc != nil {
            if (FBSDKAccessToken.currentAccessToken() != nil) {
                SocialLogin._getFBUserWithCompletionHandler(completionHandler)
            } else {
                FBSDKLoginManager().logInWithReadPermissions(["email", "public_profile"], fromViewController: vc, handler: { (result, error) -> Void in
                    if error == nil {
                        if result.isCancelled {
                            completionHandler(nil, NSError(domain: "Cancelled by user", code: 0, userInfo: nil))
                        } else {
                            SocialLogin._getFBUserWithCompletionHandler(completionHandler)
                        }
                    }
                })
            }
        }
    }
    
    private class func _getFBUserWithCompletionHandler(completionHandler: FBLoginResponse) {
        let params = ["fields": "id, name, link, first_name, last_name, email, birthday, bio ,location , friends , hometown"]
        FBSDKGraphRequest(graphPath: "me", parameters: params).startWithCompletionHandler { (connection, user, error) -> Void in
            completionHandler(user as? [NSObject : AnyObject], error)
        }
    }
    
    //MARK:- GIDSignInUIDelegate
    public func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        var viewCntrl = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController
        
        while (viewCntrl?.presentedViewController != nil) {
            viewCntrl = viewCntrl!.presentedViewController;
        }
        
        viewCntrl?.present(viewController, animated: true, completion: nil)
    }
    
    public func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
}*/

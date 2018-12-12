![smartData: Scaling Expectations in Swift](https://www.smartdatainc.com/wp-content/uploads/2018/09/logo.png)

# SD-iOSArchitecture
To kick start iOS project at smart Data

## Architecture Defines Targets for:
        - iOSArchitecture
        - iOSArchitectureTests
        - iOSArchitectureUITests
        
To focus upon the main target i.e. iOSArchitecture and to kick start we offer basic functionality of UserLogin which exists in approximately all the applications. 

## Folder Structure :
Architecture is following MVC pattern using Swift Language with version 4.0 and folder structure defined for this is:

### Controllers: That contains all the controllers that manages context between Modal and View. To kick start controllers contained in folder
            - BaseViewControler -> Base of every controller inherited from UIViewController. It is required so that if any change is required in all the screens of application then code for that can be written in base so impelementation can be done around the app.
            - LoginViewController -> Login View that is defined first and is the landing page when application opens. It is inherited from BaseViewController.
            - HomeViewController -> After Login where user lands is Home and it is also inherited from BaseViewController.

### Models : All the modals and information in modal form can be saved in modal classes will be defined here. Currently contains:
            - User -> This is example of modal that is created after user login to modal the user information.
            
### Views : All the custom views that are required in app shall come under this. It doesnot contain any file but contributes to the architecture.

### Libraries: Any external libraries that work as plug and play or libraries that does not contribute to Pods or Carthage shall come under this folder. Currently does not contain anything.

### Applications : AppDelegate class is singleton class defining application instance and window of application. This folder contains AppDelegate and Bridging Header.
            - AppDelegate -> Defining window and application instance.
            - Bridging Header -> In case some ObjectiveC code needs to merge with Swift, this class will act as bridge between two languages.

### Network : Contains the classes that communicates with external servers using the network and all network related information: Currently contains:
            - APIService -> Contains all methods for hitting and external API for server communication. 
            - UserService -> Example how to hit API for login and essential for KickStart.
            - SDSocialLogin -> For login to google and facebook this class is helpful. It is currently commented but you can uncomment if you want to do social login using google and facebook.

### Helpers: Any class that does not belong to Controller, Modal or View but is helpful to ease the code and save redundancy shall come under this folder. Example for this is color schemes classes of app, AppContants, UserDefaults, Shared Singeltons, StringsContants, Identifiers. Currently contains:
            - Constants -> Contributes to Configurations and Identifiers as example. 

### Stores: Store the data in application. Contains:
            - AppInstance -> Stores the data for application lifecycle so that the information that is required during application lifecycle can directly be fetched from here.
            - CoreDataStackManager -> Contains the information to access the CoreData of application.
            
### Categories : Categories are extensions that helps to develop custom methods that are very frequently used in the applications like String Modifications, Alerts, Bundles. Contains: 
            - String+Extension -> Methods to modify string like clipping, range, shift, email validation, phonenumber validation etc.
            - AlertManager -> To show alerts in application.
            - UIApplication -> Extension of our application instance.
            - Bundle -> Information of our application like version number, identifier, build number.
            
### Custom: Any custom created class that contributes as our library like any music player, video player, photoviewer, imagepicker or any custom plug'n'play shall come under this. Currently contains:
            - SoundEngine -> used to play quick sounds that are of small length.
       
### Main : Storyboard is used draw viewcontrollers.
            
## How to use:

### SDSocialLogin: Platform to login with Facebook and Google
Login with FB: add FBSDKLoginKit through pod and install pod. then uncomment following lines
    
    ```swift
    import FBSDKLoginKit
    public typealias FBLoginResponse = ([NSObject : AnyObject]?, NSError?) -> Void
    
    public class SocialLogin: NSObject {
    
        private static var _sInstance : SocialLogin!
    
        public class func getInstance() -> SocialLogin {
            if(_sInstance == nil) {
                _sInstance = SocialLogin()
            }
    
            return _sInstance
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
      }
    
    ```
    
Write following lines of code in your controller to login via facebook
    
    ```swift
        SocialLogin.loginWithFacebookAtViewController(vc: self) { (user, error) in
            if let error = error {
                //you received error
            } else {
                //you received user information
            }
        }

    ```

Login with Google: add GoogleSignIn through pod and install pod. then uncomment following lines
        
        ```swift
        import GoogleSignIn
        public typealias GoogleLoginResponse = (GIDGoogleUser?, NSError?) -> Void

        public class SocialLogin: NSObject, GIDSignInDelegate, GIDSignInUIDelegate {

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
            signIn?.clientID = ApplicationConstants.googleClientID()//pass your googleclientid
            signIn?.shouldFetchBasicProfile = true
            signIn?.scopes = [FXWebRequestURL.getGooglePlusAuthURL()] //pass your scope
            signIn?.delegate = socialLogin
            signIn?.uiDelegate = socialLogin
            signIn?.signIn()
        }

        public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if _googleResponseHandler != nil {
                _googleResponseHandler!(user, error as NSError?)
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
    }


        ```

Write following lines of code in your controller to login via google and also pass your google client id and scope in the methods as mentioned above.

        ```swift
        SocialLogin.loginWithGoogleWithCallBackResponse ({ (user, error) in
            if let error = error {
                //you received error
            } else {
                //you received user information
            }
        })

        ```
### Calling API :
Best method is provided in UserService.swift class under Networks.

### Sound Enginge:
To play a song from URL write following line of code:

```swift

SoundEngine.sharedEngine.play( /*pass your url*/ )

```

To play a short sound from local file write following line of code:

```swift

SoundEngine.sharedEngine.playSound(for: /*pass your filename*/ : /*pass bool*/ )

```
### Alert Manager:

```swift

AlertManager.showOKAlert(pass your params )     //to show alert

AlertManager.showActionSheet(pass your params ) // to show action sheet.

```



//
//  loginViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 7/3/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class loginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: { (result, error) -> Void in
            if (error == nil){
                var fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                if(fbloginresult.isCancelled) {
                    //Show Cancel alert
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    //self.returnUserData()
                    thisKiter.getFBStuff()
                    //fbLoginManager.logOut()
                }
                self.performSegue(withIdentifier: "toApp", sender: self)
            }
            else
            {
                print(error)
            }
        })
    }
    func circleButton(button: UIButton)
    {
        button.layer.borderWidth = 1
        button.layer.masksToBounds = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = button.frame.height/3
        button.clipsToBounds = true
    }
    /*
    func returnUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print("facebook login result: \(result)")
                    
                    let data:[String:AnyObject] = result as! [String : AnyObject]
                    
                    
                    let userName : NSString? = data["name"]! as? NSString
                    thisKiter.name = userName! as String
                    
                    //let facebookID : NSString? = data["id"]! as? NSString
                    //let firstName : NSString? = data["first_name"]! as? NSString
                    //let lastName : NSString? = data["last_name"]! as? NSString
                    //let email : NSString? = data["email"]! as? NSString
                    //print("\(firstName) \(lastName)")
                }
                else
                {
                    print(error)
                }
            })
        }
        else{
            print("access token is nil, why?")
        }
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        circleButton(button: loginButton)
        if((FBSDKAccessToken.current()) != nil)
        {
            self.performSegue(withIdentifier: "toApp", sender: self)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
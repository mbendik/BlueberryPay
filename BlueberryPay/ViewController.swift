//
//  ViewController.swift
//  BlueberryPay
//
//  Created by Marek Bendík on 01/08/15.
//  Copyright © 2015 BlueberryApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AppDelegate().homeController = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signInSilently()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//
//  AppDelegate.swift
//  BlueberryPay
//
//  Created by Marek Bendík on 01/08/15.
//  Copyright © 2015 BlueberryApps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var homeController: UIViewController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setupGoogleSignIn()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if (userDefaults.stringForKey("name") != nil) {
            openPayController()
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
            return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
            if (error == nil) {
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setObject(user.userID, forKey: "userId")
                userDefaults.setObject(user.authentication.idToken, forKey: "idToken")
                userDefaults.setObject(user.profile.name, forKey: "name")
                userDefaults.setObject(user.profile.email, forKey: "email")
                
                openPayController()
            } else {
                print("\(error.localizedDescription)")
            }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!, withError error: NSError!) {
            // Perform any operations when the user disconnects from app here.
            // ...
    }
    
    func setupGoogleSignIn(){
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func openPayController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyboard.instantiateViewControllerWithIdentifier("PayViewController") as! PayViewController
        
        if self.window != nil {
            self.window!.rootViewController = rootController
        }
    }
}
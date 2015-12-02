//
//  AppDelegate.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 23/11/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //creo el Storyboard
        var sb : UIStoryboard
        
        //hay que comprobar si es la primera vez y bajar el json de internet
        downloadJSON()
//        let def = NSUserDefaults.standardUserDefaults()
//        if !def.boolForKey("firsTime") {
//            print("no lo tengo. Comentada la opcion de ponerlo a true")
//            //def.setBool(true, forKey: "firsTime")
//            
//        } else {
//            //ya lo tengo
//            print("lo tengo")
//        }
        
        //creamos la interfaz grafica
        sb = UIStoryboard(name: "Hackerbook", bundle: nil)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = sb.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    
    func downloadJSON () {
        //comprueba si ya se ha bajado la primera vez el json, si es que no, se lo baja y lo guarda
        let def = NSUserDefaults.standardUserDefaults()
        if !def.boolForKey("firsTime") {
            //es la primera vez, me lo tengo que bajar
            print("no lo tengo. Comentada la opcion de ponerlo a true")
            //def.setBool(true, forKey: "firsTime")
            
        } else {
            //ya lo tengo
            print("lo tengo")
        }
        
        
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


}


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
        checkDownloadedJSON()

        
        //creamos la interfaz grafica
        sb = UIStoryboard(name: "Hackerbook", bundle: nil)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = sb.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    
    func checkDownloadedJSON () {
        //comprueba si ya se ha bajado la primera vez el json, si es que no, se lo baja, lo trata y lo guarda localemnte en un fichero
        //en el caso de que ya lo haya tratado, entonces se salta este paso. Al arrancar la clase NCTLibrary, esta lee el fichero y se genera el modelo
        let def = NSUserDefaults.standardUserDefaults()
        if !def.boolForKey("firsTime") {
            //creo los direcorios que voy a necesitar. creo info info/img info/pdf. En info guardo el json y los pdf y las imagenes en cada uno de los otors
            let filemgr = NSFileManager.defaultManager()
            let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            
            let docsDir = dirPaths[0]
            let img = docsDir.stringByAppendingString("/info/img")
            do {
                try filemgr.createDirectoryAtPath(img, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
            let pdf = docsDir.stringByAppendingString("/info/pdf")
            do {
                try filemgr.createDirectoryAtPath(pdf, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
            
            //crear directorio
            
            
            //es la primera vez, me lo tengo que bajar
            if let arrayLibros = downloadJSON() {
                //aqui tengo un array de StructBook, se supone que por algunlado se ha bajado las imagenes ylos pdf y se han tratado los paths para
                //que se lean en local. Se guardan en data/json data/pdfs data/imgs y el nombre que tuvieran en su momento

                print (arrayLibros)
                
                

                //[data writeToFile:dataPath atomically:YES];
                
            }
            
            
            
            print("no lo tengo. Comentada la opcion de ponerlo a true")
            //def.setBool(true, forKey: "firsTime")
            
        }
        
        
    }
    
    
    func downloadJSON() -> [StructBook]? {
        //me bajo el json de forma sincrona, el ! va xq como lo pongo a mano se que va y va bien
        
        //necesito un array de los libros structurados, que podria dar error si no hay nada
        var result : [StructBook]? = nil

        let url = NSURL(string: "https://t.co/K9ziV0z3SJ")!
        //me bajo los datos, se los enchufo al JSONSerializartion y si todo va bien devuelvo un JSONArray
        do {
            if let data = NSData(contentsOfURL: url),
                libros = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONArray {
                    //tengo un JSONArray de libros sin tratar, me devuelve un array de StrucBook
                    print("Libros del JSON\n",libros,"\n-------------------------------")
                    
                    //dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        result = decodeJSONArrayToStructBookArray(books: libros)
                    //})
                    
            }
        } catch {
            print("Error al descargar el json")
        }
        
        //        if let j =  NSData(contentsOfURL: url), let js = NSString(data: j, encoding: NSUTF8StringEncoding) {
        //            progressView.setProgress(1.0, animated: true)
        //            return js
        //        }
        //        progressView.setProgress(1.0, animated: true)
        return result
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


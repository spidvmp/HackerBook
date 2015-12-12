//
//  AppDelegate.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 23/11/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //creo el Storyboard
        var sb : UIStoryboard
        
        
        //hay que comprobar si es la primera vez y bajar el json de internet
        checkDownloadedJSON()
        
        //creamos la interfaz grafica
        sb = UIStoryboard(name: "Hackerbook", bundle: nil)
        //definimos el tamalo de la pantall
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //Le indicamos que el rootvirecontroller es la primera pantalla del Storyboard
        window?.rootViewController = sb.instantiateInitialViewController()
        
        //genero el controlador del split, que es el root casteado a UISplitviewController
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        //el controlador izquierdo es el primer elemento del splitviewcontroller
        let leftNavController = splitViewController.viewControllers.first as! UINavigationController
        
        //pongo el boton del detalle cuando se gira
        leftNavController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        
        //pongo el delegado
        splitViewController.delegate = self
        //
        //let masterViewController = leftNavController.topViewController as! HackerTVController
        
        //el detailcontroller es el segundo de los controladores del splitviewcontroller
        //let detailViewController = splitViewController.viewControllers.last as! DetalledeVista
        
        //ponemos 
        
        
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeFavorite", name: FAVORITE_NOTIFICATION, object: nil)
        
        
        window?.makeKeyAndVisible()
        return true
    }
    
    
    // MARK: - Split view
    
//    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
//        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
//        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
//        if topAsDetailController.detailItem == nil {
//            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//            return true
//        }
//        return false
//    }
    
//    func changeFavorite() {
//        print("App delegate, recibo la notificacion ")
//    }
    
    func checkDownloadedJSON () {
        //comprueba si ya se ha bajado la primera vez el json, si es que no, se lo baja, lo trata y lo guarda localemnte en un fichero
        //en el caso de que ya lo haya tratado, entonces se salta este paso. Al arrancar la clase NCTLibrary, esta lee el fichero y se genera el modelo
        let def = NSUserDefaults.standardUserDefaults()
        //print("Puesto a piñon fijo que es la primera vez")
        
        
        if !def.boolForKey("firsTime") {
            //creo los direcorios que voy a necesitar. creo info . En info guardo el json y un directorio por cada libro, donde guardo la imagen y el pdf, asi evito nombres repetidos
            let filemgr = NSFileManager.defaultManager()
            let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            
            
            
            let docsDir = dirPaths[0]
            //me genero el nombre del fichero de datos para grabar
            let img = docsDir.stringByAppendingString("/info")
            
            
            //let info = NSBundle.mainBundle().bundlePath
            //let img2 = info.stringByAppendingString("/info")
            
            do {
                try filemgr.createDirectoryAtPath(img, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
//            let pdf = docsDir.stringByAppendingString("/info/pdf")
//            do {
//                try filemgr.createDirectoryAtPath(pdf, withIntermediateDirectories: true, attributes: nil)
//            } catch let error as NSError {
//                print(error.localizedDescription);
//            }
            
            
            
            
            //es la primera vez, me tengo que bajar todo y tratarlo
            //dowloadJSON se baja el JSOn trata los datos, se baja las imagenes y pdf y devuelve un array de SrtuctBook
            if let arrayLibros = downloadJSON() {
                //aqui tengo un array de StructBook, se supone que por algun lado se ha bajado las imagenes ylos pdf y se han tratado los paths para
                //que se lean en local. Se guardan en data/json data/pdfs data/imgs y el nombre que tuvieran en su momento
                //ahora voy a generar un array de NCTBook y guardarlo en un NSData. Cuando arranque NC¡TLibray leera ese NSData. No le importara si es la primera vez o ya lleva 100 años creado
             
                saveModel(datos: arrayLibros, inKey:"modeloLibros")

            }

            
            
            //print("no lo tengo. Comentada la opcion de ponerlo a true para no volver a leer")
            def.setBool(true, forKey: "firsTime")
            
        }
        
        
    }
    

    //func downloadJSON() -> [StructBook]? {
    func downloadJSON() -> [NCTBook]? {
        //me bajo el json de forma sincrona
        
        //necesito un array de los libros structurados, que podria dar error si no hay nada
        var resultStructBooks : [StructBook]? = nil
        var resultBooksArray: [NCTBook]? = nil

        let url = NSURL(string: "https://t.co/K9ziV0z3SJ")!
        //me bajo los datos, se los enchufo al JSONSerializartion y si todo va bien devuelvo un JSONArray
        do {
            if let data = NSData(contentsOfURL: url),
                libros = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONArray {
                    //tengo un JSONArray de libros sin tratar, me devuelve un array de StructBook
                  
                    //dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        resultStructBooks = decodeJSONArrayToStructBookArray(books: libros)
                    //})
                    
                    //ahora transformo el array de Struct en array de NCTBook
                    resultBooksArray = decodeStructBooksToNCTBooksArray(books: resultStructBooks!)
                    
            }
        } catch {
            print("Error al descargar el json")
        }
        //return resultStructBooks
        return resultBooksArray
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


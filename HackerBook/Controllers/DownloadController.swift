//
//  DownloadController.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 2/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

class DownloadController: UIViewController, NSURLSessionDownloadDelegate {
    
    /*
    creo un modelo de datos de tipo NCTLibrary que liego se lo paso al controlador de la tabla para que saquelos datos de ahi. Lo creo por cojones para que no sea opcional y ademas ya se que model existe, aunque su contenido este vacio. Cuando salga de aqui debera tener datos, si es que notampoco deberia pasar nada, el array saldria vacio
    */
    var model : NCTLibrary!
    
    
    //defino la tarea en segundo plano y la tarea de download
    var downloadTask: NSURLSessionDownloadTask!
    var backgroundSession: NSURLSession!
    
    

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var statusText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //defino la progressview, si tiene los datos como va todo en local se supone que ira muy rapido
        //progressView.setProgress(0.0, animated: false)
        //progressView.progressTintColor = UIColor.defaultColorHacker()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        print("estoy en download controller")
        //compruebo si ya me lo he bajado por primera vez o no y genero el modelo de un sitio o de otro y selo paso a la tabla
        let def = NSUserDefaults.standardUserDefaults()
        if !def.boolForKey("firsTime") {
            //es la primera vez, me lo tengo que bajar
            print("no lo tengo. Comentada la opcion de ponerlo a true")
            //def.setBool(true, forKey: "firsTime")
            if let arrayLibros = downloadJSON() {
                statusText.text="Analizando JSON"
                print (arrayLibros)
                //aqui deberria tener los datos correctamente, deberia bajar las fotos y generar la libreria
                
                
            }

            
            
            
            
            
            
            /*
            let backgroundSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("backgroundSession")
            
            backgroundSession = NSURLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
            
            //me bajo el json, el ! va xq como lo pongo a mano se que va y va bien
            let url = NSURL(string: "https://t.co/K9ziV0z3SJ")!
            downloadTask = backgroundSession.downloadTaskWithURL(url)
            downloadTask.resume()
            */
            
        } else {
            //ya lo tengo, leo del userdefualts y se los paso a la libreria
            print("lo tengo")
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func cargarJSON(){
//        //compruebo si ya me lo he bajado por primera vez o no y genero el modelo de un sitio o de otro y selo paso a la tabla
//        let def = NSUserDefaults.standardUserDefaults()
//        if !def.boolForKey("firsTime") {
//            //es la primera vez, me lo tengo que bajar
//            print("no lo tengo. Comentada la opcion de ponerlo a true")
//            //def.setBool(true, forKey: "firsTime")
//            json = downloadJSON()
//            statusText.text="Analizando JSON"
//            print (json)
//            
//            
//            
//            
//            
//            
//            
//            /*
//            let backgroundSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("backgroundSession")
//            
//            backgroundSession = NSURLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
//            
//            //me bajo el json, el ! va xq como lo pongo a mano se que va y va bien
//            let url = NSURL(string: "https://t.co/K9ziV0z3SJ")!
//            downloadTask = backgroundSession.downloadTaskWithURL(url)
//            downloadTask.resume()
//            */
//            
//        } else {
//            //ya lo tengo
//            print("lo tengo")
//        }
//        
//    }
    
    //MARK: - SessionDownload Delegate
    func URLSession(session: NSURLSession,
        downloadTask: NSURLSessionDownloadTask,
        didFinishDownloadingToURL location: NSURL){
            
            //cuando termina de bajarselo lo guarda
            let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let documentDirectoryPath:String = path[0]
            //let fileManager = NSFileManager()
            let destinationURLForFile = NSURL(fileURLWithPath: documentDirectoryPath.stringByAppendingString("/file.pdf"))
            
//            if fileManager.fileExistsAtPath(destinationURLForFile.path!){
//                showFileWithPath(destinationURLForFile.path!)
//            }
//            else{
//                do {
//                    try fileManager.moveItemAtURL(location, toURL: destinationURLForFile)
//                    // show file
//                    showFileWithPath(destinationURLForFile.path!)
//                }catch{
//                    print("An error occurred while moving file to destination url")
//                }
//            }
    }
    
    func URLSession(session: NSURLSession,
        downloadTask: NSURLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64){
            
            //esto se llama cada vez que recibe informacion y va  actualizando la progressbar
            progressView.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
            print("incremnto progreso ",Float(totalBytesWritten)/Float(totalBytesExpectedToWrite),"%")
    }
    
    
    func downloadJSON() -> [StructBook]? {
        //me bajo el json de forma sincrona, el ! va xq como lo pongo a mano se que va y va bien
        
        //necesito un array de los libros structurados, que podria dar error si no hay nada
        var result : [StructBook]? = nil
        
        
        
        statusText.text="JSON"
        progressView.setProgress(0.0, animated: true)
        let url = NSURL(string: "https://t.co/K9ziV0z3SJ")!
        //me bajo los datos, se los enchufo al JSONSerializartion y si todo va bien devuelvo un JSONArray
        do {
            if let data = NSData(contentsOfURL: url),
                libros = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONArray {
                    //tengo un JSONArray de libros sin tratar, me devuelve un array de StrucBook
                    print("Libros del JSON\n",libros,"\n-------------------------------")
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        result = decodeJSONArrayToStructBookArray(books: libros)
                    })

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

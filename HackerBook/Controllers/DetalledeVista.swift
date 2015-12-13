//
//  DetalledeVista.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 7/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

class DetalledeVista: UIViewController {

    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var autores: UILabel!
    @IBOutlet weak var tags: UITextView!
    @IBOutlet weak var tituloText: UITextView!
    @IBOutlet weak var favorito: UIButton!
    @IBOutlet weak var leer: UIButton!
    
//    //defino detailItem que es el 
//    var detailItem: AnyObject? {
//        didSet {
//            // Update the view.
//            self.configureView()
//        }
//    }


    //defino el modelo de libro que voy a recibir, sobre este hay que modificar la vista
    //defino libro como opcional y asi me evito los inicializadores
    
    
    var libro : NCTBook? {
        //observador de propiedades, sirve para saber cuando se ha modificado una propiedad
        //willSet se llama antes de asignarse la variable y didSet despues de asignarse, asi que en willSet libro es nil y en didSet ya tiene valor
        willSet {

        }
        didSet {
            self.updateUI()

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Libro=",libro)
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("VISTA CARGADA")
        
        //updateUI()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateUI() {
        //ha cambiado el modelo, pongo los nuevos valores
        //El titulo lo pongo en un textview porque hay titulos muy grandes, asi ocupan varias lineas
        
        //es posible que libro llegue a nil, asi que se comprueba, si tiene datos se rellena
        //ademas hay que comprobar cada OUTLET antes de asignarlo xq es posible que la primera vez no este todavia creado, y petaria
        if let l = self.libro {
            //si libro tiene valor relleno
            if let tit = self.tituloText {
                tit.text = l.titulo
            }
            if let aut = self.autores {
                aut.text = l.autores?.joinWithSeparator(", ")
            }
            if let tg = self.tags {
                tg.text = l.tags?.joinWithSeparator(", ")
            }
            //saco directorios
            let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let docsDir = dirPaths[0]
            
            if let port = self.portada {
                port.image = UIImage(contentsOfFile: docsDir.stringByAppendingString((l.imagenPath)!))
                port.layer.cornerRadius = 5.0
                port.clipsToBounds = true
            }
            
            if let fv = self.favorito {
                if l.favorite {
                    
                    fv.setTitle("Quitar Favorito", forState: UIControlState.Normal)
                    
                } else {
                    fv.setTitle("Favorito", forState: UIControlState.Normal)
                }
            }
        }
        
    }
    
    @IBAction func LeerLibro(sender: AnyObject) {
        //performSegueWithIdentifier("PDFView", sender: sender)
    }
    
    
    
    @IBAction func Favorito(sender: AnyObject) {
        
        //cambio el valor del libro si es favorito o no
        libro?.changeFavorite = !libro!.favorite
        //NSNotificationCenter.defaultCenter().postNotificationName(FAVORITE_NOTIFICATION, object: self, userInfo: ["libro": self])
        //NSNotificationCenter.defaultCenter().postNotificationName(FAVORITE_NOTIFICATION, object: self)
        if libro!.favorite {
            self.favorito.setTitle("Quitar Favorito", forState: UIControlState.Normal)
        
        } else {
            self.favorito.setTitle("Hacer Favorito", forState: UIControlState.Normal)
            //NSNotificationCenter.defaultCenter().postNotificationName(FAVORITE_NOTIFICATION, object: self, userInfo: ["libro": self])
        }
        
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PDFView" {
            
            let destino = segue.destinationViewController as? PDFView
            destino?.libro = libro
            
            
        }
    }


}

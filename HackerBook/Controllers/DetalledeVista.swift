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
    @IBOutlet weak var tags: UILabel!
    
    @IBOutlet weak var tituloText: UITextView!
    
    //defino el modelo de libro que voy a recibir, sobre este hay que modificar la vista
    //defino libro como opcional y asi me evito los inicializadores
    var libro : NCTBook? {
        //observador de propiedades, sirve para saber cuando se ha modificado una propiedad
        //willSet se llama antes de asignarse la variable y didSet despues de asignarse, asi que en willSet libro es nil y en didSet ya tiene valor
        willSet {

        }
        didSet {
            //updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //El titulo lo pongo en un textview porque hay titulos muy grandes, asi ocupan varias lineas
        
        tituloText.text = libro?.titulo
        autores.text = libro?.autores?.joinWithSeparator(", ")
        tags.text = libro?.tags?.joinWithSeparator(", ")
        let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let docsDir = dirPaths[0]

        portada.image = UIImage(contentsOfFile: docsDir.stringByAppendingString((libro?.imagenPath)!))
        portada.layer.cornerRadius = 5.0
        portada.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateUI() {
        //ha cambiado el modelo, pongo los nuevos valores
        
        print(libro)
        print(libro!.titulo)
        //tags.text = "hola"

        
        
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

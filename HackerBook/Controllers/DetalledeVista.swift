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
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autores: UILabel!
    @IBOutlet weak var tags: UILabel!
    
    
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
        titulo.text = libro?.titulo
        autores.text = libro?.autores?.joinWithSeparator(",")
        tags.text = libro?.tags?.joinWithSeparator(",")

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

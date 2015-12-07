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
        willSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateUI() {
        //ha cambiado el modelo, pongo los nuevos valores
        titulo.text = libro?.titulo
        
        
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

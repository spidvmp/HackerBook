//
//  FileUtils.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 4/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//
import Foundation


//MARK: - Graba y lee el modelo
func saveModel(datos d:[NCTBook], inKey k:String){
    //recibo un array de NCTBook y lo guardo en la key que me pases, asi puedo tener un modelo para libros y otro para tags
   
    let data = NSKeyedArchiver.archivedDataWithRootObject(d)
    //grabo en Userdefaults con el tag que me han pasado
    //let def =
    NSUserDefaults.standardUserDefaults().setObject(data, forKey: k)
    //def .setObject(data, forKey: k)
}


func loadModel(inKey k:String) -> [NCTBook]{
    
    //let def = NSUserDefaults.standardUserDefaults()
    //primero saco el NSData
    let data = NSUserDefaults.standardUserDefaults().objectForKey(k) as? NSData
    if let libritos = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? [NCTBook]{
        return libritos
    }
    return []
}


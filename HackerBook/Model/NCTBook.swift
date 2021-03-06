//
//  NCTBook.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 23/11/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation


class NCTBook: NSObject, NSCoding {
    
    //propiedades del libro
    //MARK: - Properties
    let titulo : String?
    let autores : [String]?
    let tags : [String]?
    let nombreImagen : String?
    let nombrePdf : String?
    let imagenPath : String?
    let pdfPath : String?
    var favorite : Bool
    var changeFavorite : Bool{
        get{
            return favorite
        }
        set(value){
            favorite = value
            //if value {
                //es verdadero, añadir grupo favoritos envio notificacion
            
            NSNotificationCenter.defaultCenter().postNotificationName(FAVORITE_NOTIFICATION, object: self, userInfo: ["libro": self])
            //} else {
                //es falso, sacar de grupo favoritos
            //}
        }
        
    }

    
    //inicializador designado
    //MARK: - Init
    //favorito por defecto es falso
    init(titulo: String? , autores:[String]? , tags:[String]?, nombreImagen: String?, nombrePdf: String?, imagenPath: String?, pdfPath: String?, favorite: Bool = false){
        
        self.titulo = titulo
        self.autores = autores
        self.tags = tags
        self.nombreImagen = nombreImagen
        self.nombrePdf = nombrePdf
        self.imagenPath = imagenPath
        self.pdfPath = pdfPath
        self.favorite = favorite
    }
    
    //codificadores para grabarlo como nsdata
    
    required convenience init ( coder aDecoder: NSCoder){
        let titulo = aDecoder.decodeObjectForKey("titulo") as! String
        let autores = aDecoder.decodeObjectForKey("autores") as! [String]
        let tags = aDecoder.decodeObjectForKey("tags") as! [String]
        let nombreImagen = aDecoder.decodeObjectForKey("nombreImagen") as! String
        let nombrePdf = aDecoder.decodeObjectForKey("nombrePdf") as! String
        let imagenPath = aDecoder.decodeObjectForKey("imagenPath") as! String
        let pdfPath = aDecoder.decodeObjectForKey("pdfPath") as! String
        let favorite = aDecoder.decodeBoolForKey("favorite")
        
        //self.init(titulo: titulo, autores: autores, tags: tags, urlImagen: urlImagen, urlPDF: urlPDF, photo: photo, pdf: pdf, favorite: favorite)
        self.init(titulo: titulo, autores: autores, tags: tags, nombreImagen: nombreImagen, nombrePdf: nombrePdf, imagenPath: imagenPath, pdfPath: pdfPath, favorite: favorite)

    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(titulo, forKey:"titulo")
        aCoder.encodeObject(autores, forKey:"autores")
        aCoder.encodeObject(tags, forKey:"tags")
        aCoder.encodeObject(nombreImagen, forKey:"nombreImagen")
        aCoder.encodeObject(nombrePdf, forKey:"nombrePdf")
        aCoder.encodeObject(imagenPath, forKey:"imagenPath")
        aCoder.encodeObject(pdfPath, forKey:"pdfPath")
        aCoder.encodeBool(favorite, forKey: "favorite")
        
    }

    //MAR: - Proxys
    
    var proxyForComparasion : String {
        //genero un string para poder comparar los 2 objetos
        get {
            //genero el string de autores
            let aut : String = ""
            autores?.map({aut.stringByAppendingString($0)})
            return "\(titulo)\(aut)"
        }
    }
    
    
}


//MARK: - Operadores

//hago operadores para comparar 2 libros y saber cual es mayor que el otro
func == (lhs: NCTBook, rhs: NCTBook) -> Bool {
    
    //compruebo si es el mismo objeto
    guard !( lhs == rhs ) else {
        return true
    }
    
    //comparo los datos necesarios para saber si son iguales
    return (lhs.proxyForComparasion == rhs.proxyForComparasion)
    
}

func < (lhs: NCTBook, rhs: NCTBook) -> Bool {
    //en este caso solo compruebo el orden alfabetico del titulo
    return (lhs.titulo < rhs.titulo)
}
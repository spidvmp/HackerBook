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
    let urlImagen : String?
    let urlPDF : String?
    let favorite : Bool
    
    //inicializador designado
    //MARK: - Init
    //favorito por defecto es falso
    init(titulo: String? , autores:[String]? , tags:[String]?, urlImagen: String?, urlPDF: String?, favorite: Bool = false){
        
        self.titulo = titulo
        self.autores = autores
        self.tags = tags
        self.urlImagen = urlImagen
        self.urlPDF = urlPDF
        self.favorite = favorite
    }
    
    //codificadores para grabarlo como nsdata
    
    required convenience init ( coder aDecoder: NSCoder){
        let titulo = aDecoder.decodeObjectForKey("titulo") as! String
        let autores = aDecoder.decodeObjectForKey("autores") as! [String]
        let tags = aDecoder.decodeObjectForKey("tags") as! [String]
        let urlImagen = aDecoder.decodeObjectForKey("urlImagen") as! String
        let urlPDF = aDecoder.decodeObjectForKey("urlPDF") as! String
        let favorite = aDecoder.decodeBoolForKey("favorite")
        
        self.init(titulo: titulo, autores: autores, tags: tags, urlImagen: urlImagen, urlPDF: urlPDF, favorite: favorite)
//        self.titulo = aDecoder.decodeObjectForKey("titulo") as? String
//        self.autores = aDecoder.decodeObjectForKey("autores") as? [String]
//        self.tags = aDecoder.decodeObjectForKey("tags") as? [String]
//        self.urlImagen = aDecoder.decodeObjectForKey("urlImagen") as? String
//        self.urlPDF = aDecoder.decodeObjectForKey("urlPDF") as? String
//        self.favorite = aDecoder.decodeBoolForKey("favorite")
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(titulo, forKey:"titulo")
        aCoder.encodeObject(autores, forKey:"autores")
        aCoder.encodeObject(tags, forKey:"tags")
        aCoder.encodeObject(urlImagen, forKey:"urlImagen")
        aCoder.encodeObject(urlPDF, forKey:"urlPDF")
        aCoder.encodeBool(favorite, forKey: "favorie")
        
    }
    
    
}
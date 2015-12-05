//
//  NCTBook.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 23/11/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation


class NCTBook {
    
    //propiedades del libro
    //MARK: - Properties
    let titulo : String?
    let autores : [String]?
    let tags : [String]?
    let urlImagen : String?
    let urlPDF : String?
    let favorite : Bool?
    
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
    
    init ( coder aDecoder: NSCoder!){
        self.titulo = aDecoder.decodeObjectForKey("titulo") as? String
        self.autores = aDecoder.decodeObjectForKey("autores") as? [String]
        self.tags = aDecoder.decodeObjectForKey("tags") as? [String]
        self.urlImagen = aDecoder.decodeObjectForKey("urlImagen") as? String
        self.urlPDF = aDecoder.decodeObjectForKey("urlPDF") as? String
        self.favorite = aDecoder.decodeObjectForKey("favorite") as? Bool
    }
    
    func encodeWithCoder(aCoder: NSCoder!){
        aCoder.encodeObject(titulo, forKey:"titulo")
        aCoder.encodeObject(autores, forKey:"autores")
        aCoder.encodeObject(tags, forKey:"tags")
        aCoder.encodeObject(urlImagen, forKey:"urlImagen")
        aCoder.encodeObject(urlPDF, forKey:"urlPDF")
        aCoder.encodeObject(favorite, forKey:"favorite")
        
    }
    
    
}
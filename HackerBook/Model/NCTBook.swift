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
    
    
}
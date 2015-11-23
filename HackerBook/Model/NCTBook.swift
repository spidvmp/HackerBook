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
    let autores : NSMutableArray
    let tags: NSMutableArray
    let urlImagen : NSURL
    let urlPDF : NSURL
    
    //inicializador designado
    //MARK: - Init
    init(titulo: String?, autores:NSMutableArray, tags: NSMutableArray, urlImagen: NSURL, urlPDF: NSURL){
        
        self.titulo = titulo
        self.autores = autores
        self.tags = tags
        self.urlImagen = urlImagen
        self.urlPDF = urlPDF
    }
    
    
}
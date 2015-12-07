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
    
    //inicializador designado
    //MARK: - Init
    //favorito por defecto es falso
    //init(titulo: String? , autores:[String]? , tags:[String]?, urlImagen: String?, urlPDF: String?, photo: NSURL?, pdf : NSURL?, favorite: Bool = false){
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
    
    
    
}
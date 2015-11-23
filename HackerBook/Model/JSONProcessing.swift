//
//  JSONProcessing.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 23/11/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit


//MARK: - Alias

typealias JSONObject = AnyObject
typealias JSONDictionary = [String: JSONObject]
typealias JSONArray = [JSONDictionary]

//MARK: - Erores
enum JSONProcessingError : ErrorType {
    case WrongURLFormatForJSONResource
    case ResourcePointedByURLNotReachable
    case JSONParsingError
    case WrongJSONFormat
}

//MARK: - Claves del modelo
enum JSONKeys: String {
    case titulo = "title"
    case autores = "authors"
    case tags = "tags"
    case imagen = "image_url"
    case pdf = "pdf_url"
}

//MARK: - Decoding
func decode(libro json:JSONDictionary) throws -> NCTBook {
    
    //comprobar que los valores que vienen son validos
    //saco el titulo
    let titulo = json[JSONKeys.titulo.rawValue] as? String
    
    //los autores tiene que ser un array
    guard let autores = json[JSONKeys.autores.rawValue] as? NSMutableArray else {
        //no es un array
        throw JSONProcessingError.WrongJSONFormat
    }
    
    //los tags tiene que ser un array
    guard let tags = json[JSONKeys.tags.rawValue] as? NSMutableArray else {
        //no es array
        throw JSONProcessingError.WrongJSONFormat
    }
    
    //la imagen
    guard let urlimg = json[JSONKeys.imagen.rawValue] as? String,
        //img = UIImage(named: urlimg) else {
        //esto esta de momento, habta que cambiarlo
        img = NSURL(string: urlimg) else{
            throw JSONProcessingError.ResourcePointedByURLNotReachable
    }
    
    //el pdf
    guard let urlpdf = json[JSONKeys.pdf.rawValue] as? String,
        pdf = NSURL(string: urlpdf) else {
            throw JSONProcessingError.ResourcePointedByURLNotReachable
    }
    
    
    return NCTBook(titulo: titulo, autores: autores, tags: tags, urlImagen: img, urlPDF: pdf)
    
}
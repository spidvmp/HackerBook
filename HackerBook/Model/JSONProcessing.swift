//
//  JSONProcessing.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 23/11/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

/*
Voy a utilizar 2 arrays, uno con los libros ordenados alfabeticamente y el otro ordenador por los tags
El array de los libros tiene por cada elemento un libro, que es un diccionarion con el autor, imagen, pdf, tag, etc
El arra de los tags
*/

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

//MARK: - Structs
//Esta estructura es la del libro una vez leido del json, extraido, comprobado y con los enlaces a la imagen y al pdf que estarn en local
//Los libros tienes por narices titulo, autor, tag, imagen y pdf. No se especifica que exista libro son tag o libro sin autor
struct StructBook {
    let titulo: String
    let autores : [String]
    let tags : [String]
    let imagen : NSURL
    let pdf : NSURL
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

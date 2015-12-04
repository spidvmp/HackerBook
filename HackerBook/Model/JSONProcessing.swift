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
    let titulo: String?
    let autores : String?
    let tags : String?
    let imagen : String?
    let pdf : String?
}

//MARK: - Decoding

func decodeJSONArrayToStructBookArray(books json:JSONArray) -> [StructBook] {
    //recibo un JSONArray y devuelvo un array de libros estructurados. Este paso es despues de leer el JSON, esto procesara los datos y los devuelve estructurados
    
    
    //array de libros estructurados
    var result = [StructBook]()
    
    //me recorro el array del json y analizo libro por libro
    do {
        
        for dict in json {
            print("Analizando ",dict )
            //convierto el diccionario que contienen los datos del libro y devuelvo un StructBook
            let l = try decodeJSONDictionaryToStructBook (libro: dict)
            //añado la estructura del libro a los resultados
            result.append(l)
            
        }
        
    } catch {
        
        print("Cagada mortal en decodeJSONArrayToStructBookArray")
    }
    
    return result
    
}

func decodeJSONDictionaryToStructBook(libro l:JSONDictionary) throws -> StructBook {
    
    /*
    recibo un elemento del array de libros que es un diccionario. He de sacar toda la indformacion y comprobar que es correcta y devuelvo y elemento StructBook. Aqui tambien cambio el nombre del pdf y de la imagen del libro para tener la relacion interna, ya que me bajare de interner esa imagen y ese pdf para guardarlo en local
    */
    
    
    //comprobamos la imagen
    guard let imageUrl = l[JSONKeys.imagen.rawValue] as? String
        //imageName = imageUrl.componentsSeparatedByString("/")
        //imagen = imageName[imageName.count]
    //imagen = UIImage(named: imageUrl)
        else {
            print("error con la imagen")
            throw JSONProcessingError.ResourcePointedByURLNotReachable
    }
    //tengo la imagenUrl, necesito solo el nombre, lo troceo separado por /
    let imagenRip = imageUrl.componentsSeparatedByString("/")
    let imagen :String? = imagenRip[imagenRip.count - 1]
    
    //troceo el pdf para quedarme solo con el nombre del pdf
    guard let pdfFile = l[JSONKeys.pdf.rawValue] as? String else {
        print("error con el pdf")
        throw JSONProcessingError.ResourcePointedByURLNotReachable
    }
    //tengo el pdf, lo troceo separado por /
    let pdfRip = pdfFile.componentsSeparatedByString("/")
    let pdf : String? = pdfRip[pdfRip.count - 1]

    
    
    
    //saco datos que no hay que comprobar
    let titulo = l[JSONKeys.titulo.rawValue] as? String
    let autores = l[JSONKeys.autores.rawValue] as? String
    let tags = l[JSONKeys.tags.rawValue] as? String
    
    //let pdf = l[JSONKeys.pdf.rawValue] as? String
    
    return StructBook (titulo: titulo,
        autores: autores,
        tags: tags,
        imagen: imagen,
        pdf: pdf)
}



//MARK: - Inicializadores de conveniencia de libroo y libreria 
extension NCTBook {
    
    //inicializador de conveniencia de libros, recibe un struct y lo convierte a objeto NCTBook para que se guarde en el array de libros
    convenience init (structBook l:StructBook) {
        
        //aqui tengo los datos a tal y como se van a guardar
        
        self.init(titulo : l.titulo,
            autores: l.autores,
            tags: l.tags,
            urlImagen: l.imagen,
            urlPDF: l.pdf
            
            )
    }
}


//extension NCTLibrary {
//    
//    //inicializador de conveniencia, recive un array de structBook y crea el objeto libro, que lo guarda en el array de libros
//    convenience init(libros l:[StructBook]){
//        //me recorro el
//        
//        
//    }
//}











/*
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
*/

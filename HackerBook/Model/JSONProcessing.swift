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
//nombres que me voy a encontrar en el Json, no son los mismos que en la estructura, xq la imagen y el pdf los trato y cambian
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
    let autores : [String]?
    let tags : [String]?
    let nombreImagen : String?
    let nombrePdf : String?
    let imagenPath : String?
    let pdfPath: String?
}

//MARK: - Decoding

func decodeJSONArrayToStructBookArray(books json:JSONArray) -> [StructBook] {
    //recibo un JSONArray y devuelvo un array de libros estructurados. Este paso es despues de leer el JSON, esto procesara los datos y los devuelve estructurados
    
    
    //array de libros estructurados
    var result = [StructBook]()
    
    //me recorro el array del json y analizo los datos recibidos libro por libro
    do {
        
        for dict in json {
            //print("Analizando ",dict )
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
    //let filemgr = NSFileManager.defaultManager()
    let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    
    let docsDir = dirPaths[0]
print(docsDir)
    //saco datos que no hay que comprobar
    let titulo = l[JSONKeys.titulo.rawValue] as? String
    
    //los autores me vienen en un string separado por , lo transformo a array y limpio los espacion anterior y posterior si los hubiera
    guard let a = l[JSONKeys.autores.rawValue] as? String,
        autores:[String] = a.componentsSeparatedByString(",").map({$0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())})
        else {
            print("Error al procesar autores")
            throw JSONProcessingError.ResourcePointedByURLNotReachable
    }
    
    //los tags me vienen en un string separado por , lo transformo como autores
    guard let t = l[JSONKeys.tags.rawValue] as? String,
        tags:[String] = t.componentsSeparatedByString(",").map({$0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())})
        else {
            print("error al procesar los tags")
            throw JSONProcessingError.ResourcePointedByURLNotReachable
    }

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
    let nombreImagen :String? = imagenRip.last
    
    //troceo el pdf para quedarme solo con el nombre del pdf
    guard let pdfUrl = l[JSONKeys.pdf.rawValue] as? String else {
        print("error con el pdf")
        throw JSONProcessingError.ResourcePointedByURLNotReachable
    }
    //tengo el pdf, lo troceo separado por /
    let pdfRip = pdfUrl.componentsSeparatedByString("/")
    let nombrePdf : String? = pdfRip.last

    
    //aqui tengo el dato completo de lo que me tengo que bajar, asi que es aqui donde me lo bajo
    
    //print("ESTA COMENTADO bajar la imagen y pdf ",pdfUrl, imageUrl)

    //Me bajo la imagen y la guardo en /info/img/nombreImagen
    let iurl = NSURL(string: imageUrl)
    print("Bajando ",iurl)
    let imgdata = NSData(contentsOfURL: iurl!)
    let imagenPath = docsDir.stringByAppendingString("/info/img/").stringByAppendingString(nombreImagen!)
  
    imgdata?.writeToFile(imagenPath, atomically: true)
    
    //bajo el pdf y lo guardo en /info/pdf/nombreImagen
    let purl = NSURL(string: pdfUrl)
    print("Bajando ", purl)
    let pdfdata = NSData(contentsOfURL: purl!)
    let pdfPath = docsDir.stringByAppendingString("/info/pdf/").stringByAppendingString(nombrePdf!)
    
    pdfdata?.writeToFile(pdfPath, atomically: true)

    
    
    return StructBook (titulo: titulo,
        autores: autores,
        tags: tags,
        nombreImagen: nombreImagen,
        nombrePdf: nombrePdf,
        imagenPath: imagenPath,
        pdfPath: pdfPath )
}


func decodeStructBooksToNCTBooksArray(books l:[StructBook]) -> [NCTBook]?{
    //recibo el array de structbook y genero el array de NCTBook
    
    let res = l.map({NCTBook.init(structBook: $0)})
    
    return res
    
    
}


//MARK: - Inicializadores de conveniencia de libroo y libreria
extension NCTBook {
    
    //inicializador de conveniencia de libros, recibe un struct y lo convierte a objeto NCTBook para que se guarde en el array de libros
    convenience init (structBook l:StructBook) {
        
        //aqui tengo los datos a tal y como se van a guardar
        
        self.init(titulo : l.titulo,
            autores: l.autores,
            tags: l.tags,
            nombreImagen: l.nombreImagen,
            nombrePdf: l.nombrePdf,
            imagenPath: l.imagenPath,
            pdfPath: l.pdfPath
            )
    }
}

//
//  NCTLibrary.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 23/11/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation


class NCTLibrary {

    //MARK: - Properties
    //voy a tener 4 arrays, uno de libros alfabeticamente, otra de tags y como contenido de cada elemento tendre un objeto NCTBook
    //la tercera tabla sera el modelo original, que lo sacare de la lectura del fichero, le modificare los favoritos y sera el que guarde
    //la cuarta es un array con las tas ordenadas alfabeticamente, siendo favoritos la primera
    private var books: [NCTBook]
    private var booksByTags: [String:[NCTBook]]
    private var modeloOriginal: [NCTBook]
    private var tags: [String]
    
    
    //MARK: - init
    init(){
        //Se que tengo el modelo de libros en un fichero que he de leer y despues he de procesar para generar la tabla de libros y la tabla de tags
        //no lo proceso ni grabo desde el principio, xq si me cambian un favorito deberia modificarlo en 2 tablas y grabar 2 ficheros, asi que mantengo
        //el original que es el que cambio y grabo
        
        //inicializo los arrays
        books = Array<NCTBook>()
        booksByTags = Dictionary<String, Array<NCTBook>>()
        modeloOriginal = Array<NCTBook>()
        tags = Array<String>()
        
        //lo primero que tengo que hacer el recuperar el modelo de datos que esta grabado en el fichero. EN caso de que no lea nada devuelve un array vacio
        modeloOriginal = loadModel(inKey: "modeloLibros")
        
        //obtengo los tags que hay
        tags = getTagsFromModel()
        
        //genero los libros que hay ordenados alfabeticamente
        books = getBooksInAlphabeticalOrder()
        
        
    }
    
    //MARK: - Computed Variables
    
    var booksCount : Int {
        get{
            let count: Int = books.count
            return count
        }
    }
    

    
    //MARK: - Methods
    func bookCountForTag(tag: String) -> Int{
        /*
        recibe un string como tag, cuenta cuantos libros tienen ese tag y devuelve lo que ha contado
        */
        
        return (self.booksForTag(tag)?.count)!

    }
    
    func booksForTag(tag:String) -> [NCTBook]? {
        /*
        recibe un String como tag y devuelve un array con todos los libros que tienene ese tag
        */
        var librosConTag:[NCTBook]?
        
        //me recorro toda la libreria y bisco si en el tag en el array de tags
        for l in books {
            let li = l as? NCTBook
            //compruebo si tiene el tag
            //if ( l.tags.contains(tag)) {
            //    librosConTag?.append(li!)
            //}
        }
        return librosConTag
        
    }
    
    func bookAtIndex(index i: Int) -> NCTBook? {
        //me envian un indice y en la tabla de libros le devuelvo el libro que hay
        //si me pasa un valor que se sale del indice devuelve nil
        //esta tabla esta ordenada alfabeticamente, asi qeu coincide con el orden de la tabla
        if i < 0 || i > booksCount {
            return nil
        }
        return books[i]
        
    }
    
//    func bookAtIndex(tag:String, index: Int) -> NCTBook? {
//        /*
//        Recibe un String como tag y un indice, busca los libros con ese tag y devuelve el que este en el orden index
//        */
//        
//        //saco los loibros con ese tag
//        if let b : [NCTBook] = self.booksForTag(tag) {
//            //vigila que index sea menos que el numero de elementos que hay, si no, cagada
//            guard index < b.count else {
//                return nil
//            }
//            return b[index]
//        }
//        
//        return nil;
//    }

    //MARK: - Funciones de inicializacion
    func getTagsFromModel() -> [String] {
        
        var resultado:[String] = ["Favoritos"]
        
        //me recorro el modelo y guardo los tags en un conjunto, de esta forma me evito comprobar si se repiten, luego los ordeno, los meto en un array y lo devuelvo
        var tagSet = Set<String>()
        //como el tag es opcional me lo tengo que recorrer 2 veces para que me lo de correctamente, el xq? pues no se, pero funciona
        modeloOriginal.map({$0.tags.map({$0.map({tagSet.insert($0)})})})
        //el set lo transformo a array, lo ordeno, le pongo la primera letra mayuscula y se lo añado a la tabla resultado que ya tiene primero a Favoritos
        Array(tagSet).sort({$0 < $1}).map({resultado.append($0.capitalizedString)})
        //resultado.first("Favoritos")!
        //print(resultado)
      return resultado
    }
    
    func getBooksInAlphabeticalOrder() -> [NCTBook] {
        //del original los ordeno alfabeticamente y lo devuelvo
        return modeloOriginal.sort({$0.titulo < $1.titulo})
        
    }

}

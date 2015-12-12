
//  NCTLibrary.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 23/11/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation


class NCTLibrary  {

    //MARK: - Properties
    //voy a tener 4 arrays, uno de libros alfabeticamente, otra de tags y como contenido de cada elemento tendre un objeto NCTBook
    //la tercera tabla sera el modelo original, que lo sacare de la lectura del fichero, le modificare los favoritos y sera el que guarde
    //la cuarta es un array con las tas ordenadas alfabeticamente, siendo favoritos la primera
    private var books: [NCTBook]
    private var booksByTags: [String:Set<NCTBook>]
    private var modeloOriginal: [NCTBook]
    private var tags: [String]

    
    //MARK: - init
    init(){
    
        
        //Se que tengo el modelo de libros en un fichero que he de leer y despues he de procesar para generar la tabla de libros y la tabla de tags
        //no lo proceso ni grabo desde el principio, xq si me cambian un favorito deberia modificarlo en 2 tablas y grabar 2 ficheros, asi que mantengo
        //el original que es el que cambio y grabo
        
        //inicializo los arrays
        books = Array<NCTBook>()
        booksByTags = Dictionary<String, Set<NCTBook>>()
        modeloOriginal = Array<NCTBook>()
        tags = Array<String>()
        
        //lo primero que tengo que hacer el recuperar el modelo de datos que esta grabado en el fichero. EN caso de que no lea nada devuelve un array vacio
        modeloOriginal = loadModel(inKey: MODELO_LIBROS)
        
        //obtengo los tags que hay ordenados alfabeticamente, esto me servira para sacar las secciones. Aqui esta incluido Favoritos el primero
        //Todos los tags tendran algun libro, ya que el listado de tags los saco cuando me recorro los libros
        tags = self.getTagsFromModel()
        
        //genero los libros que hay ordenados alfabeticamente
        books = self.getBooksInAlphabeticalOrder()
        
        //genero los libros ordenados por tag, es un diccionario de tag:conjunto de libros
        booksByTags = self.getBooksByTag()


        
        
    }
    
    
    //MARK: - Computed Variables

    
    var booksCount : Int {
        get{
            let count: Int = books.count
            return count
        }
    }
    
   

    
    //MARK: - datasource delegate Libros alfabeticos

    //Genero una variable computada para saber rapidamente si hay o no algo en favoritos
    var hayFavoritos : Bool {
        get{
            if  countBooksForTag(FAVORITOS) > 0 {
                return true
            } else {
                return false
            }
        }
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
    
    //MARK: - Datasource delegate Libros por tag
    func countNumberOfTags() -> Int {
        //he de comprbar si hay algo en favoritos
        //if  countBooksForTag("Favoritos") > 0 {
        if hayFavoritos {
            return tags.count
        } else {
            //no hay favoritos, asi que he de restar elprimer elemento de tags
            return tags.count - 1
        }
        
    }
    func countBooksForTag(tag: String) -> Int{
        /*
        recibe un string como tag, cuenta cuantos libros tienen ese tag y devuelve lo que ha contado. Ese tag ya vieen capitalizado
        */
        let conj = self.booksByTags[tag]
        return (conj?.count)!
        
    }
    
    func countBooksForSection(section: Int) -> Int {
        //en la tabla me envian un numero para indicar la seccion. Esa seccion corresponde con un tag segun la tabla tags, de ahi saco el nombre del tag
        //Depende de si hay favoritos o no, la seccion cambia, ya que si no hay favoritos habra tags.count -1 secciones, Asi que hay que ir comprobando
        if hayFavoritos {
            return countBooksForTag(tags[section])
        } else {
            //no hay favoritos, asi que la seccion 0 corresponde con el tag que esta en tags[1], asi que sumo 1 a la seccion para que me devuelva el valor correcto
            return countBooksForTag(tags[section + 1])
        }
    }
    
    func booksForTag(tag:String) -> [NCTBook]? {
        /*
        recibe un String como tag y devuelve un array con todos los libros que tiene ese tag ordenados alfabeticamente
        */
        var librosConTag:[NCTBook]
        //inicializo librosConTag, ya no es opcional, en el peor de los casos es un array sin elementos, pero ya existe
        librosConTag = Array<NCTBook>()
        let c = booksByTags[tag]
        
        //en c esta el conjunto con los libros que hay que devlver en orden alfabetico
        for each in c! {
            librosConTag.append(each)
        }
        
        //ahora lo ordeno alfabeticamente
        librosConTag.sortInPlace({$0 < $1})

        return librosConTag
        
    }
    
    func bookAtIndexPath(indexPath ip: NSIndexPath) -> NCTBook? {
        /*
        Recibe el indexPath, de ahi puedo sacat el tag (seccion) y que libro de esa seccion
        */
        
        //obtengo la seccion, calculando si hay favorito o no
        var tag : String
        if hayFavoritos {
            tag = tags[ip.section]
        } else {
            tag = tags[ip.section + 1]
        }
        
        
        //obtengo el listado de libros ordenados que hay en ese tag
        if let l = booksForTag(tag) {
            //si me ha devuelto algo, entoces solo devuelvo el elemento x que corresponda con ip.row
            return l[ip.row]
        } else {
            return nil
        }
    }

    //MARK: - Funciones de inicializacion
    func getTagsFromModel() -> [String] {
        
        var resultado:[String] = [FAVORITOS]
        
        //me recorro el modelo y guardo los tags en un conjunto, de esta forma me evito comprobar si se repiten, luego los ordeno, los meto en un array y lo devuelvo
        var tagSet = Set<String>()
        //como el tag es opcional me lo tengo que recorrer 2 veces para que me lo de correctamente, el xq? pues no se, pero funciona
        modeloOriginal.map({$0.tags.map({$0.map({tagSet.insert($0)})})})
        //el set lo transformo a array, lo ordeno, le pongo la primera letra mayuscula y se lo añado a la tabla resultado que ya tiene primero a Favoritos
        Array(tagSet).sort({$0 < $1}).map({resultado.append($0.capitalizedString)})

      return resultado
    }
    
    func getBooksInAlphabeticalOrder() -> [NCTBook] {
        //del original los ordeno alfabeticamente y lo devuelvo
        return modeloOriginal.sort({$0.titulo < $1.titulo})
        
    }
    
    func getBooksByTag() -> [String:Set<NCTBook>] {
        
        //voy a necesitar un diccionario en el que voy metiendo todos los tags con sus libros.
        var arr = Dictionary<String, Set<NCTBook>>()

        //me recorro los tags que hay para generar el array con la clave y el conjunto vacio, estoy seguro que todos los tags tienen al menos un libro, de esta forma me evito hacer un if para saber si ya esta creado el conjunto o no
        tags.map({arr[$0] = Set<NCTBook>()})
        
        //me recorro el modeloOriginal y por cada libro lo voy metiendo en cada conjunto del tag
        for each in modeloOriginal {
            //pongo el tag en mayusculas xq es asi como lo tengo en la tabla de tags
            each.tags!.map({arr[$0.capitalizedString]?.insert(each)})
            if  each.favorite {
                //es favorito, ademas lo inserto en el tag de Favorites
                arr[FAVORITOS]?.insert(each)
            }
        }
        return arr
        
    }
    
    func tagNameForSection(section : Int ) -> String {
        if hayFavoritos {
            return tags[section]
        } else {
            return tags[section + 1]
        }
        
    }
    

    //MARK: - Notifications
    func chageFavoriteBook(libro : NCTBook?) {
        
        //busco el libro en modeloOrigional, para ponerlo como favorito y grabarlo para la proxima vez
        if let i = modeloOriginal.indexOf(libro!) {
            //encontramos el indice, lo cambiamos, favorite ya llega cambiado
            modeloOriginal[i] = libro!
            //grabo el modelo para la proxima vez
            saveModel(datos: modeloOriginal, inKey: MODELO_LIBROS)
            
            //dependiendo del valor que tenga ahora el libro, lo añado o lo quito del array de favoritos, que esta en BooksByTag[0]
            if  libro!.favorite {
                //es favorito, asi que lo tengo que añadir
                booksByTags[FAVORITOS]?.insert(libro!)
            } else {
                //tengo que quitarlo
                booksByTags[FAVORITOS]?.remove(libro!)
            }
            
        }
    }

    func saveLastBook(libro: NCTBook) {
        //han seleccionado un libro, guardo el indice que tienen en la tabla books para que vuelva a aparecer alcargar la app
        //busco el indice
        if let i = books.indexOf({$0.titulo == libro.titulo}) {
            //esta en i, lo guardo
            NSUserDefaults.standardUserDefaults().setInteger(i, forKey: LAST_BOOK)
        }

    }


}

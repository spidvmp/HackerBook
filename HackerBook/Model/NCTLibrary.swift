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
    //voy a tener 2 arrays, uno de libros alfabeticamente y otra de tags y como contenido de cada elemento tendre un objeto NCTBook
    private var books: [NCTBook]
    let tags: NSMutableArray
    
    
    //MARK: - Computed Variables
    
    var booksCount : Int {
        get{
            let count: Int = self.books.count
            return count
        }
    }
    
    //MARK: - init
    init(){
        self.books = []
        self.tags = []
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
    
    func bookAtIndex(tag:String, index: Int) -> NCTBook? {
        /*
        Recibe un String como tag y un indice, busca los libros con ese tag y devuelve el que este en el orden index
        */
        
        //saco los loibros con ese tag
        if let b : [NCTBook] = self.booksForTag(tag) {
            //vigila que index sea menos que el numero de elementos que hay, si no, cagada
            guard index < b.count else {
                return nil
            }
            return b[index]
        }
        
        return nil;
    }
    
}

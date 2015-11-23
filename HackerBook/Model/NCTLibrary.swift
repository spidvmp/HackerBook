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
    let libros: NSMutableArray
    let tags: NSMutableArray
    
    
    //MARK: - Computed Variables
    
    var booksCount : Int {
        get{
            let count: Int = self.libros.count
            return count
        }
    }
    
    //MARK: - init
    init(){
        self.libros = []
        self.tags = []
    }
    
    //MARK: - Methods
    func bookCountForTag(tag: String?) -> Int{
        /*
        recibe un string como tag, cuenta cuantos libros tienen ese tag y devuelve lo que ha contado
        */
        
        return 1
    }
    
    func booksForTag(tag:String?) -> [NCTBook]? {
        /*
        recibe un String como tag y devuelve un array con todos los libros que tienene ese tag
        */
        return nil
        
    }
    
    func bookAtIndex(tag:String?, index: Int) -> NCTBook? {
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

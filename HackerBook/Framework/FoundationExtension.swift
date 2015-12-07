//
//  FoundationExtension.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 7/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation


extension NSBundle {
    
    func URLForResource(fileName: String) -> NSURL? {
        //recibo el nombre completo, asi que tengoque trocearlo por el .
        //indicamos que devuelve un NSURL? opcional xq puede que de un error al generar el NSURL
        let tokens = fileName.componentsSeparatedByString(".")
        //devuelve un array con 2 elementos, nomnbre y extension
        //contamos que el nombre viene sin errores
        return self.URLForResource(tokens.first, withExtension: tokens.last)
    }
    
    func URLForResource(fileName: String, subdirectory: String) -> NSURL? {
        //recibo el nombre completo, asi que tengoque trocearlo por el .
        //indicamos que devuelve un NSURL? opcional xq puede que de un error al generar el NSURL
        let tokens = fileName.componentsSeparatedByString(".")
        //devuelve un array con 2 elementos, nomnbre y extension
        //contamos que el nombre viene sin errores
        return self.URLForResource(tokens.first, withExtension: tokens.last, subdirectory:  subdirectory)
    }
}


extension String {
    
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func removeWhitespaces() -> String {
        return self.replace(" ", replacement: "")
    }
}

//: Playground - noun: a place where people can play

import UIKit




let filemgr = NSFileManager.defaultManager()
let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
print (dirPaths)

let docsDir = dirPaths[0] as! String
//dataFilePath = docsDir.stringByAppendingPathComponent("data.archive")
print(docsDir)



let a = "hola,             adios          , kdofbk img ewo "
let b = Array(a.characters)
print (b)



let s = a.componentsSeparatedByString(",").map({$0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())})
print(s)
let sep = NSCharacterSet(charactersInString: ", ")
let z = a.componentsSeparatedByCharactersInSet(sep)


//var autores:[String] = nil

guard let au = a as? String,
    autores:[String] = a.componentsSeparatedByString(",").map({$0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())})
    else {
        
        print("error")
        
    }

print(au)
print(autores)
print("transformamos a NSData")
let dat:NSData = NSKeyedArchiver.archivedDataWithRootObject(autores)
print(dat)

//let auBack:[String] = NSKeyedUnarchiver.unarchiveObjectWithData(dat)
//print(auBack)

let url = NSURL(string: "http://hackershelf.com/media/cache/97/bf/97bfce708365236e0a5f3f9e26b4a796.jpg")
//let imgdata = NSData(contentsOfURL: url!)
//print(imgdata)





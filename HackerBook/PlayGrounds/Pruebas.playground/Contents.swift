//: Playground - noun: a place where people can play

import UIKit




let filemgr = NSFileManager.defaultManager()
let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
print (dirPaths)

let docsDir = dirPaths[0] as! String
//dataFilePath = docsDir.stringByAppendingPathComponent("data.archive")
print(docsDir)
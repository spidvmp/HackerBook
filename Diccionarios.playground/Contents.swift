//: Playground - noun: a place where people can play

import UIKit


//var d:  [String:Set<String>]
var d = Dictionary<String, Set<String>>()

d["A"] = Set<String>()
print(d)

d["A"]?.insert("Ana")
d["B"]?.insert("Barco")
d["A"]?.insert("Alvaro")

print(d)
if ( d["C"] == nil ){
    d["C"] = Set<String>()
}
d["C"]?.insert("casa")
d["A"]?.insert("Almendra")
d["B"]?.insert("Bien")
print(d)
//obtener datos de A
let conjunto = d["A"]
print(conjunto?.sort(<)," cont ",conjunto?.count)

print(d.keys)

d.removeValueForKey("C")
print(d)
d["B"] = Set<String>()
d["B"]?.insert("Banana")
print(d, d.count, d.values)
//cuantos elementos hay

class cl {
    let num : Int
    let nom : String
    init (num : Int, nom : String) {
        self.num = num
        self.nom = nom
    }
    
}



let z : cl = cl(num: 2,nom: "pepe")
let x : cl = cl(num: 9,nom: "lolo")
let m : cl = cl(num: 67,nom: "oiasmdg")
let ar : Array = [x,  m, z]

if let i = ar.indexOf({$0.nom == "pepe" && $0.num == 4}) {
    print (i)
}







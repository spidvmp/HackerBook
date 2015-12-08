//
//  HackerTVController.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 2/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

class HackerTVController: UITableViewController {
    
    var model : NCTLibrary!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        print("estoy en la tabla")
        //cargo el modelo
        model = NCTLibrary()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetalleDeCelda", sender: indexPath.row)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return model.booksCount
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Libros")
        
        if  cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Libros")
        }
        
        //obtenemos el libro
        let libro = model.bookAtIndex(index: indexPath.row)!

        
        
        cell?.textLabel?.text = libro.titulo
        cell?.detailTextLabel?.text = libro.autores?.joinWithSeparator(", ")
       
        let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let docsDir = dirPaths[0]
        
        let imagen = UIImage(contentsOfFile: docsDir.stringByAppendingString(libro.imagenPath!))
        cell?.imageView?.image = imagen
        
        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //averiguamos si el segue es el correcto
        if segue.identifier == "DetalleDeCelda" {
            //obtenemos el controlador de destino, esta creado pero no visible
            let destino = segue.destinationViewController as? DetalledeVista
            //ahora obtenemos la celda para sacar el libro que tenemos que pasar
            let ip = self.tableView.indexPathForSelectedRow
            //sabiendo la celda pulsada hay que llamar al metodo que me diga quelibro
            if let libro = model.bookAtIndex(index: (ip?.row)!) {
                print("libro ", libro, "destino.libro ", destino?.libro)     
                destino?.libro = libro
            }
            
        }
    }
    

}

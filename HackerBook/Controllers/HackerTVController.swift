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
    //defino un Bool para indicar si tengo que mostrar la tabla ordenada por libros alfabeticos o por tags
    var orderByTags : Bool = false
    //con esto recogemos que controlador es de detalle (DEtalledeVista)
    var detalleDeVista: DetalledeVista? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        //cargo el modelo
        model = NCTLibrary()
        
        //creo el boton para cambiar la vista de la tabla de tags a alfabetico, no le doy valor xq se actualizara en el willappear
        let menu_button = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain , target: self, action: "cambiaVista")
        self.navigationItem.rightBarButtonItem = menu_button
        
        
        //compruebo que el split
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            //Me quedo con el puntero al controlador de detalle
            self.detalleDeVista = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetalledeVista
            
            //pongo el ultimo libro visitado cuando arranca por primera vez, lo guardo en Userdefault
            let def = NSUserDefaults.standardUserDefaults()
            let last = def.integerForKey(LAST_BOOK)
            self.detalleDeVista?.libro = model.bookAtIndex(index: last)
            
            //cargo la ultima configuracion del estilo
            self.orderByTags = def.boolForKey(LAST_STYLE)
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        if orderByTags {
            self.navigationItem.rightBarButtonItem!.title = "Alfa"
        } else {
            self.navigationItem.rightBarButtonItem!.title = "Tags"
        }
        
        //me suscribo a las notificaciones de cambio de favoritos
        //yo me suscribo a FAVORITE_NOTIFICATION que me llega de cualquier obejto y ejecuto "cambioFavorito"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cambiaFavorito:", name: FAVORITE_NOTIFICATION, object: nil)
    }
    
    deinit {
        //Me quito la notificacion
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    func cambiaVista() {
        orderByTags = !orderByTags
        //guardo el ultimo estilo de vista mostrado
        NSUserDefaults.standardUserDefaults().setBool(self.orderByTags, forKey: LAST_STYLE)
        
        if orderByTags {
            self.navigationItem.rightBarButtonItem!.title = "Alfa"
        } else {
            self.navigationItem.rightBarButtonItem!.title = "Tags"
        }
        tableView.reloadData()
        
    }
    
    func cambiaFavorito(notification : NSNotification) {
        //ejecuto del mofdelo un metodo para cambiar el favorito, incluido en favoritos
        model.chageFavoriteBook(notification.object as? NCTBook)
        
        //recargo la tabla
        self.tableView.reloadData()
self.tableView.dele
        }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            performSegueWithIdentifier("DetalleDeCelda", sender: indexPath)
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //compruebo de donde saco los datos
        if orderByTags {
            return model.countNumberOfTags()
        } else {
            return 1
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orderByTags {
            return model.countBooksForSection(section)
        } else {
            return model.booksCount
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Libros")
        
        if  cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Libros")
        }
        var libro : NCTBook?
        //libro = <NCTBook>
        
        //obtenemos el libro, segun sea alfabeticamente o de tags
        if orderByTags {
            libro = model.bookAtIndexPath(indexPath: indexPath)
        } else {
            libro = model.bookAtIndex(index: indexPath.row)
        }
        
        
        cell?.textLabel?.text = libro?.titulo
        cell?.detailTextLabel?.text = libro?.autores?.joinWithSeparator(", ")
       
        let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let docsDir = dirPaths[0]
        
        let imagen = UIImage(contentsOfFile: docsDir.stringByAppendingString((libro?.imagenPath)!))
        cell?.imageView?.image = imagen
        
        return cell!
    }
    

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 20))
        let label = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, 20))
        
        if orderByTags {
            label.text = model.tagNameForSection(section)
        } else {
            label.text = ""
        }
        label.backgroundColor = UIColor.defaultColorHacker()
        
        
        headerView.addSubview(label)
        return headerView;
        
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
            //obtenemos el controlador de destino, esta creado pero no visible, es el primer elemento de un navigationcontroller, asi que hay que castear
            let destino = (segue.destinationViewController as! UINavigationController).topViewController as! DetalledeVista
            //Hago que aparezca el boton
            destino.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            destino.navigationItem.leftItemsSupplementBackButton = true
            //ahora obtenemos la celda para sacar el libro que tenemos que pasar
            let ip = self.tableView.indexPathForSelectedRow
            //sabiendo la celda pulsada hay que llamar al metodo que me diga que libro, es, pero depende de si estamos mostrando la tabla ordenada o por tags
            if  orderByTags {
                if let libro = model.bookAtIndexPath(indexPath: ip!) {
                    destino.libro = libro
                }
            } else {
                if let libro = model.bookAtIndex(index: (ip?.row)!) {
                    destino.libro = libro
                }
            }
            
            //ya tengo el libro que es. Lo guardo en el userdefaults para que la proxima vez que arranque la app aparezca
            model.saveLastBook( destino.libro!)
            
        }
    }



}

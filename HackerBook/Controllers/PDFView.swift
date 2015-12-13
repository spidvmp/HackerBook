//
//  PDFView.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 10/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit


class PDFView: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var pdfWebView: UIWebView!
    
    var libro : NCTBook? {
        //observador de propiedades, sirve para saber cuando se ha modificado una propiedad
        //willSet se llama antes de asignarse la variable y didSet despues de asignarse, asi que en willSet libro es nil y en didSet ya tiene valor
        willSet {
            
        }
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pdfWebView.delegate = self
        
        //muestra el pdf
        showPDF()
        
        //me apunto a a las notificaciones de cambio de libro
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bookDidChange:", name: BOOK_DID_CHANGE, object: nil)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    
    
    func updateUI(){
        //me han pasado el libro,
        self.title = libro?.titulo

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPDF() {
        let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0]
        let pdf = NSURL(fileURLWithPath: docsDir.stringByAppendingString((libro?.pdfPath)!))
        let pdfreq = NSURLRequest(URL: pdf)
        pdfWebView.loadRequest(pdfreq)
        
    }
    
    func bookDidChange(not : NSNotification ){
        //libro = not.object as? NCTBook
        if let dic = not.userInfo as? Dictionary<String, NCTBook> {
            libro = dic["book"]!
            
        }
        
        //print(dic, "---", dic[0])
        //libro = not.userInfo![0]?.objectForKey("book")
        
            
        showPDF()
        
    }


}

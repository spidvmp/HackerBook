//
//  PDFView.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 10/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit


class PDFView: UIViewController {
    
    
    @IBOutlet weak var pdfWebView: UIWebView!
    
    var libro : NCTBook? {
        //observador de propiedades, sirve para saber cuando se ha modificado una propiedad
        //willSet se llama antes de asignarse la variable y didSet despues de asignarse, asi que en willSet libro es nil y en didSet ya tiene valor
        willSet {
            print("will ",libro)
        }
        didSet {
            
            print("did ",libro)
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0]
        let pdf = NSURL(fileURLWithPath: docsDir.stringByAppendingString((libro?.pdfPath)!))
        let pdfreq = NSURLRequest(URL: pdf)
        pdfWebView.loadRequest(pdfreq)
    }

    
    
    func updateUI(){
        //me han pasado el libro,
        self.title = libro?.titulo

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

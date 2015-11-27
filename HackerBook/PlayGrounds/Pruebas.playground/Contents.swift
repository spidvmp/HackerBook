//: Playground - noun: a place where people can play

import UIKit

//Download
func download_request()
{
    let url:NSURL = NSURL(string: url_to_request)!
    let session = NSURLSession.sharedSession()
    
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
    
    let paramString = "data=Hello"
    request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
    
    
    let task = session.downloadTaskWithRequest(request) {
        (
        let location, let response, let error) in
        
        guard let _:NSURL = location, let _:NSURLResponse = response  where error == nil else {
            print("error")
            return
        }
        
        let urlContents = try! NSString(contentsOfURL: location!, encoding: NSUTF8StringEncoding)
        
        guard let _:NSString = urlContents else {
            print("error")
            return
        }
        
        print(urlContents)
        
    }
    
    task.resume()
    
}
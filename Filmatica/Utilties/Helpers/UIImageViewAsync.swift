//
//  UIImageViewAsync.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// extension UIImageView {
//    public func imageFromUrl(urlString: String) {
//        if let url = NSURL(string: urlString) {
//            let request = NSMutableURLRequest(url: url as URL)
//            request.setValue("<YOUR_HEADER_VALUE>", forHTTPHeaderField: "<YOUR_HEADER_KEY>")
//            NSURLSession.sharedSession.dataTaskWithRequest(request as URLRequest) {
//                (data, response, error) in
//                guard let data = data, error == nil else{
//                    NSLog("Image download error: \(error)")
//                    return
//                }
//
//                if let httpResponse = response as? NSHTTPURLResponse{
//                    if httpResponse.statusCode > 400 {
//                        let errorMsg = NSString(data: data, encoding: NSUTF8StringEncoding)
//                        NSLog("Image download error, statusCode: \(httpResponse.statusCode), error: \(errorMsg!)")
//                        return
//                    }
//                }
//
//            dispatch_async(dispatch_get_main_queue(), {
//                NSLog("Image download success")
//                self.image = UIImage(data: data)
//            })
//            }.resume()
//        }
//    }
// }

// class UIImageViewAsync: UIImageView {
//    
////    override init()
////    {
////        super.init(frame: CGRect())
////    }
//    
//    override init(frame:CGRect)
//    {
//        super.init(frame:frame)
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//    }
//    
//    func getDataFromUrl(url:String, completion: ((data: NSData?) -> Void)) {
//        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) in
//            completion(data: NSData(data: data))
//        }.resume()
//    }
//    
//    func downloadImage(url:String){
//        getDataFromUrl(url) { data in
//            dispatch_async(dispatch_get_main_queue()) {
//                self.contentMode = UIViewContentMode.ScaleAspectFill
//                self.image = UIImage(data: data!)
//            }
//        }
//    }
// }

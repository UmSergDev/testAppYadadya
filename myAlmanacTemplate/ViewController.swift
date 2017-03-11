//
//  ViewController.swift
//  myAlmanacTemplate
//
//  Created by Sergey Umarov on 10/03/2017.
//  Copyright © 2017 Sergey Umarov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var myWebView: UIWebView!
    
    var myURLString:String? //String with link for JSON page
    var myTitleString:String? //String with title
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.delegate = self
        navigationItem.title = myTitleString
        getValue(myVal: myURLString!)
    }
    
    //Alamofire deserialization function
    func getValue(myVal: String){
        Alamofire.request(myVal).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                let str = swiftyJsonVar["body"].string
                self.myWebView.loadHTMLString(str!, baseURL: nil)
            }
        }
    }
    
    
}


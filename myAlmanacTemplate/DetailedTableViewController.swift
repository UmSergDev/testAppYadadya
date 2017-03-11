//
//  DetailedTableViewController.swift
//  myAlmanacTemplate
//
//  Created by Sergey Umarov on 10/03/2017.
//  Copyright © 2017 Sergey Umarov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class DetailedTableViewController: UITableViewController{
    
    var sourceHref:String?  //String of href
    var sourceTitle:String? //String of Title
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = sourceTitle
        getValue(myVal: sourceHref!.appending(".json"))
        
    }
    
    //Alamofire deserialization function
    func getValue(myVal: String){
        Alamofire.request(myVal).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar.arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = UIColor.purple
        var dict = arrRes[indexPath.row]
        cell.textLabel?.text = dict["title"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegueNew" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! ViewController
                
                var tmpDict = arrRes[indexPath.row]
                let href = sourceHref! + "/pages/"
                let addStr = tmpDict["id"] as? Int
                let finalStr = href.appending("\(addStr!)") + ".json"
                dvc.myURLString = finalStr
                dvc.myTitleString = tmpDict["title"] as? String
                
            }
        }
    }
}

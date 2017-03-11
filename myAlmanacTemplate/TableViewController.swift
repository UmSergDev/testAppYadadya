//
//  TableViewController.swift
//  myAlmanacTemplate
//
//  Created by Sergey Umarov on 10/03/2017.
//  Copyright © 2017 Sergey Umarov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class TableViewController: UITableViewController {
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getValue(myVal: "https://yadadya-development-ycms.herokuapp.com/page_categories.json")
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
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
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! DetailedTableViewController
                var tmpDict = arrRes[indexPath.row]
                let href = "https://yadadya-development-ycms.herokuapp.com/page_categories/"
                let addStr = tmpDict["id"] as? Int
                dvc.sourceHref = href.appending("\(addStr!)")
                dvc.sourceTitle = tmpDict["title"] as? String
            }
        }
    }
    
}

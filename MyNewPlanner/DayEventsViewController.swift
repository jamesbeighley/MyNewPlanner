//
//  ViewController.swift
//  MyNewPlanner
//
//  Created by JamesBeighley on 7/17/20.
//  Copyright © 2020 james beighley. All rights reserved.
//

import UIKit
import Firebase

class DayEventsViewController: UIViewController {
    var date = ""
    
    @IBOutlet weak var eventTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = date
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CreateEventViewController
        vc.date = title!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

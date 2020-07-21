//
//  ViewController.swift
//  MyNewPlanner
//
//  Created by JamesBeighley on 7/17/20.
//  Copyright © 2020 james beighley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class DayEventsViewController: UIViewController {
    var date = ""
    var events: [Event] = [
        Event(description: "wake up", time: 480),
        Event(description: "eat breakfast", time: 500),
        Event(description: "brush teeth", time: 526),
        Event(description: "get to work", time: 600)
    ]
    let db = Firestore.firestore()
    @IBOutlet weak var eventTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = date
        eventTable.dataSource = self
        eventTable.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
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


extension DayEventsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTable.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EventCell
        cell.descriptionlabel?.text = events[indexPath.row].description
        cell.timeLabel?.text = getTime(time: events[indexPath.row].time)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func getTime(time: Int)-> String{
        let minutes = time % 60
        var hours = time / 60
        var period = "am"
        if(time>720){
            period = "pm"
        }
        if(hours>12){
            hours = hours-12
        }
        if(hours == 0){
            hours = 12
        }
        return String(hours) + ":" + String(minutes) + period
    }
}

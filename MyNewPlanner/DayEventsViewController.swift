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

class DayEventsViewController: UIViewController, UITableViewDelegate {
    var date = ""
    var events: [Event] = []
    let db = Firestore.firestore()
    @IBOutlet weak var eventTable: UITableView!
    var selectedEvent = Event(description: "", time: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = date
        eventTable.dataSource = self
        eventTable.delegate = self
        eventTable.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadmessages()
        // Do any additional setup after loading the view.
    }
    
    
    func loadmessages(){
        events = []
        db.collection((Auth.auth().currentUser?.email)!).document(title!).collection("Events").order(by: "Time").getDocuments{ (QuerySnapshot,error) in
            if let e = error{
                print("error:  \(e)")
            }
            else{
                if let snapshotDocuments = QuerySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let Description = data["Description"] as? String, let eventTime = data["Time"] as? Int{
                            let newEvent = Event(description: Description, time: eventTime)
                            self.events.append(newEvent)
                            DispatchQueue.main.async {
                                self.eventTable.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
          case "DayEventsToEvent":
            let destination = segue.destination as! EventViewController
            destination.date = title!
            destination.event = selectedEvent
            // prepare something

          case "DayToCreate":
            let destination = segue.destination as! CreateEventViewController
            destination.date = title!

          default: break
        }
        //let vc = segue.destination as! CreateEventViewController
        //vc.date = title!
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = events[indexPath.row]
        // Segue to the second view controller
        tableView.deselectRow(at: indexPath, animated: true)
        print("deselected row")
        self.performSegue(withIdentifier: "DayEventsToEvent", sender: self)
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
        if(minutes<10){
            return String(hours) + ":0" + String(minutes) + period
        }
        else{
        return String(hours) + ":" + String(minutes) + period
        }
    }
}

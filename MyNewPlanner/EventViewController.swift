//
//  EventViewController.swift
//  MyNewPlanner
//
//  Created by JamesBeighley on 7/22/20.
//  Copyright © 2020 james beighley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class EventViewController: UIViewController {
    var date = ""
    let db = Firestore.firestore()
    var event = Event(description: "", time: 0)
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = date
        timeLabel.text = getTime(time: event.time)
        descriptionLabel.text = event.description
        // Do any additional setup after loading the view.
    }
    @IBAction func deletePressed(_ sender: UIButton) {
        db.collection((Auth.auth().currentUser?.email)!).document(title!).collection("Events").document(event.description).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        _ = navigationController?.popViewController(animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

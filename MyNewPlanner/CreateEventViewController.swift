//
//  CreateEventViewController.swift
//  MyNewPlanner
//
//  Created by JamesBeighley on 7/18/20.
//  Copyright © 2020 james beighley. All rights reserved.
//

import UIKit
import Firebase
class CreateEventViewController: UIViewController {
    var date = ""
    let db = Firestore.firestore()
    @IBOutlet weak var Hour: UITextField!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var Minute: UITextField!
    @IBAction func `switch`(_ sender: UISwitch) {
        if(sender.isOn){
            period.text = "am"
        }
        else{
            period.text = "pm"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = date
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if(checkHours(hour: Hour.text!) == false){
            ErrorLabel.text = "Error: make sure Hours is 1-12"
        }
        else if(checkMinutes(minute: Minute.text!) == false){
            ErrorLabel.text = "Error: make sure Minutes is 0-59"
        }
        else{
            if let description = descriptionLabel.text, let periodtext = period.text, let minutes = Minute.text, let hours = Hour.text{
                db.collection((Auth.auth().currentUser?.email)!).document(title!).collection("Events").document(description).setData(["Time": getTime(hour: hours, minute: minutes, period: periodtext),
                "Description": description])
                { (error) in
                    if let e = error {
                    print(e)
                    }
                    else{
                        print("Success")
                    }
                }
            }
            _ = navigationController?.popViewController(animated: true)
        
        }
    }
    
    //check if hours given is a valid number 1-12
    
    func checkHours(hour: String) -> Bool{
        if let myhour = Int(hour){
            if(myhour >= 1 && myhour <= 12){
                return true
            }
            else{
                return false
            }
        }
        return false
    }
    
    
    //check if minutes given is a valid number 0-59
    
    func checkMinutes(minute:String) -> Bool{
        if let myMinute = Int(minute){
            if(myMinute >= 0 && myMinute < 60){
                return true
            }
            else{
                return false
            }
        }
        return false
    }
    
    
    //consolidate the hours, minutes and period given into a single Int representing minutes after midnight
    func getTime(hour: String, minute: String, period: String) -> Int{
        let minutes = Int(minute);
        var hours = Int(hour);
        if(hours == 12){
            hours = 0
        }
        if(period == "pm"){
            hours = hours! + 12
        }
        return hours! * 60 + minutes!
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

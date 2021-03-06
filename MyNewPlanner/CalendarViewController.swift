//
//  CalendarViewController.swift
//  MyNewPlanner
//
//  Created by JamesBeighley on 7/15/20.
//  Copyright © 2020 james beighley. All rights reserved.
//

import UIKit
import FSCalendar
import Firebase
import UserNotifications

class CalendarViewController: UIViewController, FSCalendarDelegate {
    @IBOutlet weak var calendar: FSCalendar!
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        navigationItem.hidesBackButton = true
        registerLocal()
        // Do any additional setup after loading the view.
    }
    
    func registerLocal(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]){granted,Error in
            if(granted){
                print("yes")
            }
            else{
                print("no")
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        name = formatter.string(from: date)
        performSegue(withIdentifier: "CalendarToDayEvents", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! DayEventsViewController
        print(vc)
        vc.date = name
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }
        catch let signouterror as NSError{
            print("error signing out: %@", signouterror)
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

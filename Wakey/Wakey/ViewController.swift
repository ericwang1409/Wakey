//
//  ViewController.swift
//  Wakey
//
//  Created by Eric Wang on 12/1/22.
//

import UIKit
import Firebase

public var wakeUpTime = "6:30 AM"
public var configure = false
public var joinTime = ""

class ViewController: UIViewController {
    
    //time label in app
    
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alarmTime: UIDatePicker!
    
    @IBOutlet weak var alarmCode: UITextField!
    
    @IBOutlet weak var joinCode: UITextField!
    
    //timer object to keep track of live time
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinTime = ""
        
        if (!configure)
        {
            FirebaseApp.configure()
            configure = true
        }
        
        // Do any additional setup after loading the view.
        clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
    }
    
    @objc func tick() {
        clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
    }
    
    @IBAction func setAlarm(_ sender: UIButton) {
        if (alarmCode.text == "")
        {
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter an alarm code to set an alarm", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        }
        else if (alarmCode.text != "")
        {
            let ref = Database.database().reference()

            ref.child(alarmCode.text!).child("dateTime").observe(.value, with: { (snapshot) in

                    if snapshot.value as? String != nil{
                        
                        let dialogMessage = UIAlertController(title: "Error", message: "Code already exists. Please enter a new code.", preferredStyle: .alert)
                         
                         // Create OK button with action handler
                         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                             print("Ok button tapped")
                          })
                         
                         //Add OK button to a dialog message
                         dialogMessage.addAction(ok)
                         // Present Alert to
                         self.present(dialogMessage, animated: true, completion: nil)
                        }
                    else
                    {
                        self.performSegue(withIdentifier: "alarmPage", sender: self)
                        self.uploadToCloud()
                    }
                })
        }
    }
    
    @IBAction func wakeUpTimeSelect(_ sender: UIDatePicker) {
    }
    
    func uploadToCloud(){
        let ref = Database.database().reference()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let setTime = DateFormatter.localizedString(from: alarmTime.date, dateStyle: .none, timeStyle: .short)
        let currTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)

        ref.child(alarmCode.text!).setValue(
            [
                "alarmCode": alarmCode.text!,
                "dateTime": setTime,
                "currentTime": currTime
            ]
        )
    }
    
    
    @IBAction func joinSession(_ sender: UIButton) {
        let ref = Database.database().reference()
        
        let text = joinCode.text ?? ""
        
        if (text == "")
        {
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter an alarm code to join an alarm", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        }
        else
        {
            ref.child(text).child("dateTime").observe(.value, with: { (snapshot) in

                    if let value = snapshot.value as? String{
                        
                        joinTime = value
                        
                                            }
                })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.sendPage()
        }
    }
    
    
    func sendPage() {
        performSegue(withIdentifier: "alarmPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is AlarmViewController {
            let vc = segue.destination as? AlarmViewController
            print(joinTime)
            
            if (joinTime == "")
            {
                vc?.alarmTime = DateFormatter.localizedString(from: alarmTime.date, dateStyle: .none, timeStyle: .short)
            }
            else
            {
                print(joinTime)
                vc?.alarmTime = joinTime
                joinTime = ""
            }
        }
    }
}


//
//  ViewController.swift
//  Wakey
//
//  Created by Eric Wang on 12/1/22.
//

//import the appropriate libraries
import UIKit
import Firebase

//public instance variables
public var configure = false
public var joinTime = ""

class ViewController: UIViewController {
        
    //labels and buttons from the storyboard
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alarmTime: UIDatePicker!
    
    @IBOutlet weak var alarmCode: UITextField!
    
    @IBOutlet weak var joinCode: UITextField!
    
    //timer object to keep track of live time
    var timer = Timer()
    
    //function runs when the ViewController loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //resets joinTime
        joinTime = ""
        
        //configures Firebase once only
        if (!configure)
        {
            FirebaseApp.configure()
            configure = true
        }
        
        //updates the clock and date labels from the current date
        clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
    }
    
    //runs every second to update the clock and date label
    @objc func tick() {
        clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
    }
    
    //button to set alarm
    @IBAction func setAlarm(_ sender: UIButton) {
        //check if there is an input
        if (alarmCode.text == "")
        {
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter an alarm code to set an alarm", preferredStyle: .alert)
             
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
              })
             
             dialogMessage.addAction(ok)
             self.present(dialogMessage, animated: true, completion: nil)
        }
        else if (alarmCode.text != "")
        {
            let ref = Database.database().reference()

            //queries Firebase database to see if code already exists
            ref.child(alarmCode.text!).child("dateTime").observe(.value, with: { (snapshot) in

                    if snapshot.value as? String != nil{
                        
                        let dialogMessage = UIAlertController(title: "Error", message: "Code already exists. Please enter a new code.", preferredStyle: .alert)
                         
                         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                          })
                         
                         dialogMessage.addAction(ok)
                         self.present(dialogMessage, animated: true, completion: nil)
                        }
                    else
                    {
                        self.performSegue(withIdentifier: "alarmPage", sender: self)
                        //upload new code to database
                        self.uploadToCloud()
                    }
                })
        }
    }
    
    //upload new code to database
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
    
    //join button
    @IBAction func joinSession(_ sender: UIButton) {
        let ref = Database.database().reference()
        
        let text = joinCode.text ?? ""
        
        //checks if text is empty
        if (text == "")
        {
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter an alarm code to join an alarm", preferredStyle: .alert)
             
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
              })
             
             dialogMessage.addAction(ok)
             self.present(dialogMessage, animated: true, completion: nil)
        }
        else
        {
            //updates joinTime to pass it into the next ViewController
            ref.child(text).child("dateTime").observe(.value, with: { (snapshot) in

                    if let value = snapshot.value as? String{
                        
                        joinTime = value
                        
                                            }
                })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.sendPage()
            }
        }
    }
    
    //sends to next page
    func sendPage() {
        performSegue(withIdentifier: "alarmPage", sender: self)
    }
    
    //send the alarm time to the next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is AlarmViewController {
            let vc = segue.destination as? AlarmViewController
            
            if (joinTime == "")
            {
                vc?.alarmTime = DateFormatter.localizedString(from: alarmTime.date, dateStyle: .none, timeStyle: .short)
            }
            else
            {
                vc?.alarmTime = joinTime
                joinTime = ""
            }
        }
    }
}


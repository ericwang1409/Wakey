//
//  AlarmViewController.swift
//  Wakey
//
//  Created by Eric Wang on 12/1/22.
//

import UIKit

class AlarmViewController: UIViewController {
    var alarmTime: String!
    var change: Bool! = false
    
    //labels connected to storyboard
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    var timer = Timer()
    
    //runs when ViewController loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
        
        //sets the alarm time
        alarmTimeLabel.text = alarmTime
    }
    
    //runs every second
    @objc func tick() {
        clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        
        if (clockLabel.text == alarmTimeLabel.text && !change)
        {
            performSegue(withIdentifier: "wakeUpScreen", sender: self)
            
            change = true
        }
    }

    //button to stop alarm
    @IBAction func stopAlarm(_ sender: UIButton) {
        alarmTimeLabel.text = ""
    
        self.dismiss(animated: true, completion: nil)
    }
    
}

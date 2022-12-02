//
//  ViewController.swift
//  Wakey
//
//  Created by Eric Wang on 12/1/22.
//

import UIKit
import Firebase

public var wakeUpTime = "6:30 AM"

class ViewController: UIViewController {
    
    //time label in app
    
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alarmTime: UIDatePicker!
    
    //timer object to keep track of live time
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    @IBAction func wakeUpTimeSelect(_ sender: UIDatePicker) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is AlarmViewController {
            let vc = segue.destination as? AlarmViewController
            vc?.alarmTime = alarmTime
        }
    }
}


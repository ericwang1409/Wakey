//
//  AlarmViewController.swift
//  Wakey
//
//  Created by Eric Wang on 12/1/22.
//

import UIKit

class AlarmViewController: UIViewController {
    var alarmTime: UIDatePicker!
    var change: Bool! = false
    
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    //time label in app
    
    //timer object to keep track of live time
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
        
        alarmTimeLabel.text = DateFormatter.localizedString(from: alarmTime.date, dateStyle: .none, timeStyle: .short)
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tick() {
        clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        
        if (clockLabel.text == alarmTimeLabel.text && !change)
        {
            performSegue(withIdentifier: "wakeUpScreen", sender: self)
            
            change = true
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
    @IBAction func stopAlarm(_ sender: UIButton) {
        alarmTimeLabel.text = ""
    
        self.dismiss(animated: true, completion: nil)
    }
    
}

//
//  wakeUpViewController.swift
//  Wakey
//
//  Created by Eric Wang on 12/2/22.
//

import UIKit
import AVFoundation

class wakeUpViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarm()
        // Do any additional setup after loading the view.
    }
    
    @objc func alarm() {
        let pathtosound = Bundle.main.path(forResource: "AlarmOne", ofType: "wav")!
        let url = URL(fileURLWithPath: pathtosound)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            //error handling
        }
    }
    
    @objc func endAlarm() {
        audioPlayer?.stop()
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        print("here")
        endAlarm()
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

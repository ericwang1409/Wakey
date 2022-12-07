//
//  wakeUpViewController.swift
//  Wakey
//
//  Created by Eric Wang on 12/2/22.
//

//import libraries to play sound
import UIKit
import AVFoundation

class wakeUpViewController: UIViewController {
    //creates sound object
    var audioPlayer: AVAudioPlayer?
    var mSocket = SocketHandler.sharedInstance.getSocket()

    override func viewDidLoad() {
        super.viewDidLoad()
        SocketHandler.sharedInstance.establishConnection()
        
        //rings alarm
        alarm()
        
        //checks for input from the server before playing sound
        mSocket.on("trumpet") { ( dataArray, ack) -> Void in
            self.playSound(audioName: "trumpet")
        }
        
        mSocket.on("siren") { ( dataArray, ack) -> Void in
            self.playSound(audioName: "siren")
        }
        
        mSocket.on("bruh") { ( dataArray, ack) -> Void in
            self.playSound(audioName: "bruh")
        }
        
        mSocket.on("fart") { ( dataArray, ack) -> Void in
            self.playSound(audioName: "fart")
        }
    }
    
    //plays the alarm
    @objc func alarm() {
        let pathtosound = Bundle.main.path(forResource: "AlarmOne", ofType: "wav")!
        let url = URL(fileURLWithPath: pathtosound)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 //infinite loop
            audioPlayer?.play()
        } catch {
        }
    }
    
    //play various sound effects method
    @objc func playSound(audioName : String) {
        let pathtosound = Bundle.main.path(forResource: audioName, ofType: "wav")!
        let url = URL(fileURLWithPath: pathtosound)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
        }
    }
    
    //stops the alarm
    @objc func endAlarm() {
        audioPlayer?.stop()
    }
    
    //stop button
    @IBAction func stopButton(_ sender: UIButton) {
        endAlarm()
    }

}

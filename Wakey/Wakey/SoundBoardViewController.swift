//
//  SoundBoardViewController.swift
//  Wakey
//
//  Created by Eric Wang on 12/4/22.
//

import UIKit
import AVFoundation

class SoundBoardViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    var mSocket = SocketHandler.sharedInstance.getSocket()
        
    //establishes socket connection
    override func viewDidLoad() {
        super.viewDidLoad()
        SocketHandler.sharedInstance.establishConnection()
        
    }
    
    //each function sends a message to the server when the appropriate button is selected
    @IBAction func trumptSound(_ sender: UIButton) {
        mSocket.emit("trumpet")
    }
    
    
    @IBAction func sirenSound(_ sender: UIButton) {
        mSocket.emit("siren")
    }
    
    
    @IBAction func bruhSound(_ sender: UIButton) {
        mSocket.emit("bruh")
    }
    

    @IBAction func fartSound(_ sender: UIButton) {
        mSocket.emit("fart")
    }
    
}

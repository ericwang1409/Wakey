//
//  SocketHandler.swift
//  Wakey
//
//  Created by Eric Wang on 12/4/22.
//

//socket library
import Foundation
import SocketIO

class SocketHandler: NSObject {
    //creates socket at specific IP and port
    static let sharedInstance = SocketHandler()
    let socket = SocketManager(socketURL: URL(string: "http://172.20.10.5:3000")!, config: [.log(true), .compress])
    var mSocket: SocketIOClient!

    override init() {
        super.init()
        mSocket = socket.defaultSocket
    }

    //gets socket
    func getSocket() -> SocketIOClient {
        return mSocket
    }

    func establishConnection() {
        mSocket.connect()
    }

    func closeConnection() {
        mSocket.disconnect()
    }
}

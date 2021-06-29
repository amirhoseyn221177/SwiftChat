//
//  WebSocketNetwork.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-13.
//

import Foundation
//import Combine


protocol WebSocketConnection {
    func sendText(_ message : String)
    func sendBinary(_ message : Data)
    func connect()
    func disconnect()
    var delegate : WebSocketConnectionDelegate?{
        get
        set
    }
}


protocol WebSocketConnectionDelegate {
    func onConnected(connection : WebSocketConnection)
    func onDisconnected (connection : WebSocketConnection, reason : Data?, error: Error?)
    func onError(connection: WebSocketConnection, error : Error)
    func onText(connection:WebSocketConnection,text : String)
    func onBinary(connection:WebSocketConnection , binary : Data)
}

class WebSocketNetwork : NSObject, URLSessionWebSocketDelegate, WebSocketConnection {
    var delegate: WebSocketConnectionDelegate?
    private var WebSocketTask : URLSessionWebSocketTask!
    private var urlSession : URLSession!
    var delegateQueue = OperationQueue()
    
    override init() {
        super.init()
        self.urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: delegateQueue)
        self.WebSocketTask = self.urlSession.webSocketTask(with: URL(string:"ws://10.0.0.8:8080/ws")!)
      
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        self.delegate?.onConnected(connection: self)
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        self.delegate?.onDisconnected(connection: self, reason: reason, error: nil)
    }
    
    func connect(){
        WebSocketTask.resume()
        listen()
    }
    func disconnect(){
        WebSocketTask.cancel(with: .goingAway, reason: nil)
    }
    
    
    func listen(){
        
        WebSocketTask.receive { result in
            switch result{
            case .failure(let error):
                self.delegate?.onError(connection: self, error: error)
            case .success(let message):
                switch message{
                case .string(let text):
                    self.delegate?.onText(connection: self, text: text)
                case .data(let data):
                    self.delegate?.onBinary(connection: self, binary: data)
                @unknown default:
                    fatalError("message could not be proccessed")
                }
                self.listen()
            }
        }
        
    }
    
    
    func sendText(_ message: String) {
        WebSocketTask.send(URLSessionWebSocketTask.Message.string(message)) { Error in
            if let error = Error{
                self.delegate?.onError(connection: self, error: error)
            }
        }
    }
    
    func sendBinary(_ message: Data) {
        WebSocketTask.send(URLSessionWebSocketTask.Message.data(message)) { Error in
            if let error = Error{
                self.delegate?.onError(connection: self, error: error)
            }
        }
    }
    
}

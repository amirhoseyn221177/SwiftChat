//
//  TextTestView.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import UIKit

class TextTestView: UIViewController,UITableViewDelegate, UINavigationControllerDelegate, UINavigationBarDelegate   {
//    let RsaKey = RSAKeyPair()
    let aes = AESKeyModel()
    let message = MessageModel()
    var rsa :RSAKeyPair? = nil
    var messages:[String] = ["sexpolo","abkir"]
    var  socket : WebSocketConnection!
    @IBOutlet weak var messagesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTable.delegate = self
        messagesTable.dataSource = self
        print(aes.getAESKey()!)
        rsa = RSAKeyPair(AESKey: aes.getAESKey()!)
        var _ = rsa?.CreateRSAKeyPair()

        message.textContent = "abdul"
        message.sender = "Amir polo"
        
        print("bytes of data")
        print(message.textContent?.bytes)
        aes.message = message
        aes.createAESKey()
        print("This is Binary AES")
        print(aes.getAESKey())
        var encryptedDataAES = aes.encryptData()
        var encrytedAES = rsa?.encryptAESKey()
        var decryptedAES = rsa?.decryptAESKey(encrytedAES!)
        
        print(encryptedDataAES!)
        print("encrypted AES --------------------------------")
        print(encrytedAES!)
        print("decrypted AES binary")
        print(decryptedAES)
        var decryptedData = aes.decryptData(encryptedDataAES)
        print("decrypted data")
        print(decryptedData)
        
        

        
        
        
    
//        socket = WebSocketNetwork()
//        socket.delegate = self
//        socket.connect()
//        socket.sendText("I need ab kir ")
        navigationController?.delegate = self
        
    
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("sex")
    }
    
    
    
   

}


extension TextTestView :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message")
        cell?.textLabel?.text = messages[indexPath.row]
        return cell!
        
    }
    
    
    
}


extension TextTestView : WebSocketConnectionDelegate{
    func onDisconnected(connection: WebSocketConnection, reason: Data?, error: Error?) {
        print("fuck we got disconnected !!!!")
        DispatchQueue.main.async {
            self.navigationItem.title = "Disconnected"
            self.navigationController?.navigationBar.barTintColor = UIColor.red

        }

    }
    
    func onConnected(connection: WebSocketConnection) {
        DispatchQueue.main.async {
            self.navigationItem.title = "connected"
            self.navigationController?.navigationBar.barTintColor = UIColor.blue

        }
        print("fuck yeah we are connected")
    }
        
    func onError(connection: WebSocketConnection, error: Error) {
        print(66)
        print(error.localizedDescription)
    }
    
    func onText(connection: WebSocketConnection, text: String) {
        print(text)
    }
    
    func onBinary(connection: WebSocketConnection, binary: Data) {
        print(binary.toHexString())
    }
    
    
}



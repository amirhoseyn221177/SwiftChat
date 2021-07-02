//
//  TextTestView.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import UIKit
import RealmSwift
class TextTestView: UIViewController,UITableViewDelegate {
//    let RsaKey = RSAKeyPair()
    var user : User? {
        didSet{
            print("it is set")
            navigationItem.title = user?.username
            
        }
    }
    @IBOutlet weak var textMessage: UITextField!
    @IBOutlet weak var AcessPhoto: UIButton!
    let sender = "Amir sayyar"
    let realm = try! Realm()
    @IBOutlet weak var sendButton: UIButton!
        let aes = AESKeyModel()
    let message = MessageModel()
    var rsa :RSAKeyPair? = nil
    var messages: [MessageModel] = []
    var  socket : WebSocketConnection!
    @IBOutlet weak var messagesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTable.delegate = self
        messagesTable.dataSource = self
        navigationItem.backButtonTitle = "Back"
        textMessage.delegate = self
        hideKeyBoardWhenTapped()


    
        
//        print("bytes of data")
//        print(message.textContent?.bytes)
//        aes.message = message
//        print("This is Binary AES")
//        print(aes.getAESKey())
//        var encryptedDataAES = aes.encryptData()
//        var encrytedAES = rsa?.encryptAESKey()
//        var decryptedAES = rsa?.decryptAESKey(encrytedAES!)
//
//        print(encryptedDataAES!)
//        print("encrypted AES --------------------------------")
//        print(encrytedAES!)
//        print("decrypted AES binary")
//        print(decryptedAES)
//        var decryptedData = aes.decryptData(encryptedDataAES)
//        print("decrypted data")
//        print(decryptedData)
        
        

        
        
        
    
        socket = WebSocketNetwork()
        socket.delegate = self
        socket.connect()
    
    }
//
//    func savingTextMessages(_ message : String){
//        do {
//            try realm.write{
//                realm.add(newM)
//            }
//        }catch{
//            print(error.localizedDescription)
//        }
//    }
//
//
//
//

    
    
    // send data with binarty and send the key and iv with string since they are small
    
    func finishingTheEncryption(_ message : MessageModel){
        let encryptedAESData = aes.encryptData(message)
        let encryptedAESKey = rsa?.encryptAESKey()
        let iv = aes.getIV()
        let dic : [String : Array<UInt8>] = [
            "iv" : iv,
            "key" : encryptedAESKey!,
            
        ]
        let dicString = try! JSONSerialization.data(withJSONObject: dic, options: [])
        let decoded  = String(data:dicString, encoding: .utf8)
        socket.sendText(decoded!)
        socket.sendBinary(Data(encryptedAESData!))


        
        
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        messagesTable.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    

    
    
    
   

}


extension TextTestView :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message")
        cell?.textLabel?.text = messages[indexPath.row].textContent
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
        print(error.localizedDescription)
    }
    
    func onText(connection: WebSocketConnection, text: String) {
        print(text)
    }
    
    func onBinary(connection: WebSocketConnection, binary: Data) {
        print(binary.toHexString())
    }
    
    
}


extension TextTestView :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textMessage.resignFirstResponder()
        return true
    }

    func hideKeyBoardWhenTapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(TextTestView.closeKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func closeKeyBoard(){
        view.endEditing(true)
    }
}




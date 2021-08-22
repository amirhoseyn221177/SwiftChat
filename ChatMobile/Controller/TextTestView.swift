//
//  TextTestView.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import UIKit
import RealmSwift
class TextTestView: UIViewController,UITableViewDelegate, UINavigationControllerDelegate {
    //    let RsaKey = RSAKeyPair()
    var friend : Friend? {
        didSet{
            navigationItem.title = friend?.username
            
        }
    }
    
    var user = User()
    
    var requiredKeys : [String : Array<UInt8>] = [:]
    
    var keychainModel : Keychain?
    
    var photoProcess : PhotoProcess = PhotoProcess()
    //    var messagesList : Results<MessageModel>! it is used when we immediatly save the data to the realm dataBase and it will show results live
    
    var messageList : [MessageModel] = []
    var allImages : [UIImage] = [UIImage()]
    
    enum ImageSource {
        case Library
        case Camera
    }
    
    let aes = AESKeyModel(iv: nil)
    var rsa :RSAKeyPair? = RSAKeyPair()
    
    @IBOutlet weak var PhotoUICollection: UICollectionView!
    
    var imagePicker : UIImagePickerController!
    @IBOutlet weak var textMessage: UITextField!
    let sender = "Amir sayyar"
    let realm = try! Realm()
    let message = MessageModel()
    let photoCollection = PhotoCollectionUI()
    var messages: [MessageModel] = []
    var  socket : WebSocketConnection!
    @IBOutlet weak var messagesTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardAppeared(notification:)) ,
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappeared(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rsa?.CreateRSAKeyPair()
        user.name = "amir"
        user.username = "amir2211"
        messagesTable.delegate = self
        messagesTable.dataSource = self
        navigationItem.backButtonTitle = "Back"
        photoCollection.collectionView = PhotoUICollection
        textMessage.delegate = self
        keychainModel = Keychain()
        hideKeyBoardWhenTapped()
        getAllKeysForEncryption()
        
        
        
        
        
        
        
        
        
        socket = WebSocketNetwork()
        socket.delegate = self
        socket.connect()
        
    }
    
    
    
    
    
    @objc func keyboardAppeared( notification : NSNotification){
        print("keyboard appeared")
    }
    
    @objc func keyboardDisappeared(notification : NSNotification){
        print("keyboard Disappeared")
    }

    
    
    
    @IBAction func SendMessageButtonPressed(_ sender: UIButton) {
        if let message = textMessage.text{
            let newMessage = MessageModel()
            newMessage.contentType = "text"
            newMessage.sender = user.username
            newMessage.reciever = "sara"
            newMessage.textContent = message
            newMessage.dateTime = Int64(Date().timeIntervalSince1970)
            messageList.append(newMessage)
            print(newMessage)
            let messageJustForTransformation = newMessage.copy() as! MessageModel
            encryptingTheMessage(messageJustForTransformation)
            DispatchQueue.main.async {
                self.messagesTable.reloadData()
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        messagesTable.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    
    
    
    
    
    
}


extension TextTestView :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for : indexPath)
        print(messageList)
        if let text = messageList[indexPath.row].textContent{
            cell.textLabel?.text = text
        }else{
            print(175)
            cell.textLabel?.text = "salam"
        }
        return cell
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
        print(210)
        print(text)
    }
    
    func onBinary(connection: WebSocketConnection, binary: Data) {
        print(215)
//        decryptMessage(binary)
    }
    
    
}


extension TextTestView :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textMessage.resignFirstResponder()
        return true
    }
    
    func hideKeyBoardWhenTapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyBoard))
        tap.cancelsTouchesInView = false
        messagesTable.addGestureRecognizer(tap)
        
    }
    
    @objc func closeKeyBoard(){
        view.endEditing(true)
    }
    
    
}


// MARK:  - AcessingPhotos and sending them


extension TextTestView : UIImagePickerControllerDelegate{
    @IBAction func goingToPhotos(_ sender: UIButton) {
        photoCollection.getphoto { images in
            do{
                let allimages = try images.get()
                if allimages.count > 0{
                    self.photoCollection.collectionView.isHidden = false
                    DispatchQueue.main.async {
                        self.photoCollection.collectionView.reloadData()
                    }
                }
                print(allimages)
            }catch{
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}


// MARK:  - All Encryption Stuff
extension TextTestView {
    
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
    
    func getAllKeysForEncryption(){
        let dic : [String : Array<UInt8>]? = keychainModel?.getAllKeys(username: user.username)
        if (dic != nil) {
            requiredKeys = dic!
        }else{
            print( "they could not find it ")
        }
        
    }
    
    func saveKeysToChain (){
        do{
            let aesKey = aes.createAESKey()
            
            let rsaPrivate = try rsa?.getPrivateKey()?.data().bytes
            let rsaPublic = try rsa?.getPublicKey()?.data().bytes
            if let rsaPrivate = rsaPrivate , let rsaPublic = rsaPublic , let aesKey = aesKey {
                keychainModel?.saveToKeyChain(RSAPrivateKey: rsaPrivate, RSAPublicKey: rsaPublic, AESKey: aesKey, username: user.username)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func encryptingTheMessage (_ message : MessageModel){
        if requiredKeys["AES Key"] != nil , aes.Iv != nil {
            message.iv = Data(aes.Iv!)
            let encryptedAESData = aes.encryptData(message, AesKey: requiredKeys["AES Key"]!, iv: aes.Iv!)
            let encryptedAESKey = rsa?.encryptAESKey(aesKey: requiredKeys["AES Key"]!)
            if let encryptedAESData = encryptedAESData  , let encryptedAESKey = encryptedAESKey{
                do{
                    let allDataKey : [ String : Array<UInt8>] = ["data" : encryptedAESData , "key":encryptedAESKey]
                    let json = try JSONSerialization.data(withJSONObject: allDataKey, options: .prettyPrinted)
                    let jsonData = String (data: json, encoding: .utf8)
                    message.textContent = jsonData
                    let messageRest = MessageRest(messageModel: message)
                    let jsonEncoded = try JSONEncoder().encode(messageRest)
                    socket.sendBinary(jsonEncoded)
                }catch{
                    print(error.localizedDescription)
                }
                
            }
            
            
        }
    }
    
    func decryptMessage(_ message : Data){
        let jm = try! JSONDecoder().decode(MessageRest.self, from: message)
        let textMessage = jm.textContent
        print(jm)
        let jsonTextmessage = Data(textMessage!.utf8)
        do{
            let jsonMessage = try JSONSerialization.jsonObject(with: jsonTextmessage, options: []) as? [String : Array<UInt8>]
            let encryptedAESKey = jsonMessage!["key"]
            let decryptedAESKey = rsa?.decryptAESKey(Data(encryptedAESKey!))
            let encrypteddata = jsonMessage!["data"]
            let decryptedData = aes.decryptData(encrypteddata, AesKey: decryptedAESKey!, iv: aes.Iv!)
            jm.textContent = decryptedData
            let messageModel =  jm.convertRestToDB()
            messageList.append(messageModel)
            
            DispatchQueue.main.async {
                self.messagesTable.reloadData()
            }
            
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
}









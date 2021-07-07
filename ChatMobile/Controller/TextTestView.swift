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
            navigationItem.title = user?.username
            
        }
    }
    
    var requiredKeys : [String : Array<UInt8>] = [:]
    
    var keychainModel : Keychain?
    
    var photoProcess : PhotoProcess!
//    var messagesList : Results<MessageModel>! it is used when we immediatly save the data to the realm dataBase and it will show results live
    
    var messageList : [MessageModel] = []
    @IBOutlet weak var ImageCollections: UICollectionView!
    
    enum ImageSource {
        case Library
        case Camera
    }
    
    let aes = AESKeyModel(iv: nil)
    var rsa :RSAKeyPair? = RSAKeyPair()

    
    var imagePicker : UIImagePickerController!
    @IBOutlet weak var textMessage: UITextField!
    let sender = "Amir sayyar"
    let realm = try! Realm()
    let message = MessageModel()

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
        
        messagesTable.delegate = self
        messagesTable.dataSource = self
        navigationItem.backButtonTitle = "Back"
        textMessage.delegate = self
        ImageCollections.delegate = self
        ImageCollections.dataSource = self
        ImageCollections.isHidden = true
        keychainModel = Keychain(user: user!)
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

    @IBAction func choosingPhoto(_ sender: UIButton) {
        let group = DispatchGroup()
        photoProcess = PhotoProcess(group: group)
        
        
        group.notify(queue: .global()){
            print("done")
        }
        
        

        


        
        
    }
    
    @IBAction func SendMessageButtonPressed(_ sender: UIButton) {
        if let message = textMessage.text{
            let newMessage = MessageModel()
            newMessage.ContentType = "text"
            newMessage.sender = user?.username
            newMessage.reciever = "sara"
            newMessage.textContent = message
            newMessage.dateTime = Int64(Date().timeIntervalSince1970)
            messageList.append(newMessage)
            encryptingTheMessage(newMessage)
            self.messagesTable.reloadData()
            
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
        if let messagemodel = messageList[indexPath.row].textContent{
            cell.textLabel?.text = messagemodel
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyBoard))
        tap.cancelsTouchesInView = false
        messagesTable.addGestureRecognizer(tap)
        
    }

    @objc func closeKeyBoard(){
        view.endEditing(true)
    }
    
    
}


extension TextTestView : UIImagePickerControllerDelegate{
    
    func selectImageFrom(_ source:ImageSource = .Library){
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        

    }

    
}


extension TextTestView : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        cell.backgroundColor = .red
        cell.largeContentTitle = "abpolo"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
            let dic : [String : Array<UInt8>]? = keychainModel?.getAllKeys()
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
                keychainModel?.saveToKeyChain(RSAPrivateKey: rsaPrivate, RSAPublicKey: rsaPublic, AESKey: aesKey)
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
            if encryptedAESData != nil , encryptedAESKey != nil{
                do{
                    let allDataKey : [ String : Array<UInt8>] = ["data" : encryptedAESData! , "key":encryptedAESKey!]
                    let json = try JSONSerialization.data(withJSONObject: allDataKey, options: .prettyPrinted)
                    let jsonData = String (data: json, encoding: .utf8)?.data(using: .utf8)
                    socket.sendBinary(jsonData!)
                    
                }catch{
                    print(error.localizedDescription)
                }

            }
           
            
        }
    }
    
}







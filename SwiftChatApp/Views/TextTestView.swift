//
//  TextTestView.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import UIKit

class TextTestView: UIViewController,UITableViewDelegate  {
    let RsaKey = RSAKeyPair()
    let aes = AESKeyModel()
    var messages:[String] = ["sexpolo","abkir"]

    @IBOutlet weak var messagesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTable.delegate = self
        messagesTable.dataSource = self
        aes.sendingToBackEnd()
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

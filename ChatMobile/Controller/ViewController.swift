//
//  ViewController.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextInput: UITextField!
    @IBOutlet weak var usernameTextinput: UITextField!
    var aes : AESKeyModel?
    var rsa : RSAKeyPair?
    var user = User()
    var keyChain : Keychain?
    override func viewDidLoad() {
        super.viewDidLoad()
        aes = AESKeyModel()
        user.name = "Amir"
        user.username = "Amir 2211"
        let aesKey = aes?.AES_key
        if let aesKey = aesKey{
            rsa = RSAKeyPair(AESKey: aesKey)
            let pairOfKeys = rsa?.CreateRSAKeyPair()
            let publicKey = try! pairOfKeys?.1?.data().bytes
            let privateKey = try! pairOfKeys?.0?.data().bytes
            keyChain = Keychain(user: user, prv: privateKey!, pub: publicKey!)
            keyChain?.saveToKeyChain()
            keyChain?.getAllKeys()
            keyChain?.delete()
            
        }
        
    }

    @IBAction func settinUsername(_ sender: Any) {
        
        
    }
    
}


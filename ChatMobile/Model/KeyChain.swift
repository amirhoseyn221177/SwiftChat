//
//  KeyChain.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-06-28.
//

import Foundation


class Keychain{
    var tag : String!
    var RSAPrivateKey:Array<UInt8>
    var RSAPublicKey : Array<UInt8>
    var user : User
    var RSAPublicSize : Int {
        get{
            self.RSAPublicKey.count
        }
    }
    var RSAPrivateSize : Int{
        get{
            self.RSAPrivateKey.count
        }
    }
    
    
    init(user : User,prv : Array<UInt8>,pub : Array<UInt8>) {
        self.user = user
        self.RSAPrivateKey = prv
        self.RSAPublicKey = pub
    }
    
    
    
    func saveToKeyChain(){
        let KeyObj :  [ String : Array<UInt8>] = [
            "private " : RSAPrivateKey,
            "public" : RSAPublicKey
        ]
        print(KeyObj)
        do{
            let jsonKeys = try JSONSerialization.data(withJSONObject: KeyObj, options: .prettyPrinted)
            let StringJSon = String(data: jsonKeys, encoding: .utf8)
            let query  =  [
                kSecValueData: StringJSon?.data(using: .utf8) as Any,
                kSecAttrAccount: user.username,
                kSecClass: kSecClassInternetPassword,
                kSecReturnData: true,
                kSecReturnAttributes: true
              ] as CFDictionary
            let status = SecItemAdd(query ,nil)
            guard status == errSecSuccess else {
                fatalError("adding the key faced an issue")
            }
        }catch{
            print(error.localizedDescription)
        }
   
    }
    
    
    func getAllKeys(){
        let query = [
          kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: user.username,
          kSecReturnAttributes: true,
          kSecReturnData: true,
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        guard status == errSecSuccess else {
            fatalError("could not  find the required key")
        }
        let dic = result as? NSDictionary
        if let dicConfirmed = dic{
            let username = dicConfirmed[kSecAttrAccount] ?? ""
            let passwordData = dicConfirmed[kSecValueData] as! Data
            let password = String(data: passwordData, encoding: .utf8)!
            print("Username: \(username)")
//            print("Password: \(password)")
            do{
                guard let dic  = try JSONSerialization.jsonObject(with: passwordData, options: []) as? [String : Array<UInt8>] else{
                    print("fuck")
                    return;
                }
                print(dic)
            }catch{
                print(error.localizedDescription)
            }
        
        }
 
        }
    
    
    
    func delete (){
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: user.username
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        guard status == errSecSuccess else {
            fatalError("deleting the key faced a problem")
        }
    }
     
}







//
//  KeyChain.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-06-28.
//

import Foundation


class Keychain{

    
  
    
    
    func saveToKeyChain(RSAPrivateKey:Array<UInt8>,RSAPublicKey : Array<UInt8>,AESKey : Array<UInt8>, username : String){
        let KeyObj :  [ String : Array<UInt8>] = [
            "private " : RSAPrivateKey,
            "public" : RSAPublicKey,
            "AES Key" : AESKey
        ]
        print(KeyObj)
        do{
            let jsonKeys = try JSONSerialization.data(withJSONObject: KeyObj, options: .prettyPrinted)
            let StringJSon = String(data: jsonKeys, encoding: .utf8)
            let query  =  [
                kSecValueData: StringJSon?.data(using: .utf8) as Any,
                kSecAttrAccount: username,
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
    
    
    func getAllKeys(username : String)-> [String : Array<UInt8>]?{
        let query = [
          kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: username,
          kSecReturnAttributes: true,
          kSecReturnData: true,
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        guard status == errSecSuccess else {
            return nil
        }
        
        let dic = result as? NSDictionary
        if let dicConfirmed = dic{
            let username = dicConfirmed[kSecAttrAccount] ?? ""
            let passwordData = dicConfirmed[kSecValueData] as! Data
            print("Username: \(username)")
            do{
                guard let dic  = try JSONSerialization.jsonObject(with: passwordData, options: []) as? [String : Array<UInt8>] else{
                    print("not able to convert")
                    return nil
                }
       
                return dic
            }catch{
                print(error.localizedDescription)
            }
        
        }
        return nil
 
        }
    
    
    
    func delete (username : String){
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: username
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        guard status == errSecSuccess else {
            fatalError("deleting the key faced a problem")
        }
    }
    
    
    
    func saveTheToken(username : String,token : String){
        
        let query = [
            kSecClass : kSecClassInternetPassword,
            kSecAttrAccount : username,
            kSecReturnAttributes : true,
            kSecReturnData : true,
            kSecValueData : token.data(using: .utf8) as Any
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        guard status == errSecSuccess else {
            fatalError("could not save the token")
        }
    }
    
    
    func getToken(username : String)-> String?{
        let query = [
            kSecClass : kSecClassInternetPassword,
            kSecAttrAccount : username,
            kSecReturnData : true,
            kSecReturnAttributes : true
        ] as CFDictionary
        
        var result: AnyObject?

        let status = SecItemCopyMatching(query, &result)
        guard status == errSecSuccess else {
            fatalError("could not find the token")
        }
        let dic = result as? NSDictionary
        if let dicConfirmed = dic {
            let tokenData = dicConfirmed[kSecValueData] as! Data
            let token  = String(decoding: tokenData, as: UTF8.self)
            return token
        }
        return nil
        
    }
     
}







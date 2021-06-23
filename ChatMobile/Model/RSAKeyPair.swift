//
//  RSAKeyPair.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import Foundation
import SwiftyRSA
import CryptoSwift
class RSAKeyPair{
    
    private var privateKey: PrivateKey{
        get{
            return CreateRSAKeyPair().0!
        }
    }
    private var publicKey : PublicKey{
        get{
            return CreateRSAKeyPair().1!
        }
    }
    private var AESKey : Array<UInt8>
    
    init(AESKey:Array<UInt8>) {
        self.AESKey = AESKey
    }
    
    
    
    func CreateRSAKeyPair()->(PrivateKey?,PublicKey?){
        var privateKey : PrivateKey? = nil
        var publicKey : PublicKey? = nil
        
        do{
            let keyPair = try SwiftyRSA.generateRSAKeyPair(sizeInBits: 1028)
             privateKey = keyPair.privateKey
             publicKey = keyPair.publicKey
            return (privateKey,publicKey)
        }catch{
            print(error.localizedDescription)
        }
        return (privateKey, publicKey)
    }
    
    
    func ConvertToBase64()->(String?,String?){
        var base64Private:String?
        var base64Public:String?
        do{
            base64Public = try publicKey.base64String()
            base64Private = try privateKey.base64String()
        }catch{
            print(error.localizedDescription)
        }
        
        return(base64Private,base64Public)
    }
    
    func getPrivateKey()->PrivateKey?{
        return privateKey
    }
    
    func getPublicKey()->PublicKey?{
        return publicKey
    }
    
    
    func encryptAESKey()-> Array<UInt8>?{
        do{
                let clear = ClearMessage(data: Data(AESKey))
                let encrypted = try clear.encrypted(with: publicKey, padding: .OAEP)
                return encrypted.data.bytes
            
        }catch{
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    func decryptAESKey(_ encryptedKey : String)->Array<UInt8>?{
        
        do{
            let encrypted = try EncryptedMessage(base64Encoded: encryptedKey)

                let clear = try encrypted.decrypted(with: privateKey, padding: .OAEP)
                let binary = clear.data.bytes
                return binary
            
     
        }catch{
            print(error.localizedDescription)
        }
        return nil
    }
    
}

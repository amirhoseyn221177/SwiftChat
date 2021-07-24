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
    
    private var privateKey: PrivateKey?
    private var publicKey : PublicKey?
    
    
   
    
    func CreateRSAKeyPair(){
        var privateKey : PrivateKey? = nil
        var publicKey : PublicKey? = nil
        
        do{
            let keyPair = try SwiftyRSA.generateRSAKeyPair(sizeInBits: 1028)
             privateKey = keyPair.privateKey
             publicKey = keyPair.publicKey
            self.privateKey = privateKey
            self.publicKey = publicKey
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    func ConvertToBase64()->(String?,String?){
        var base64Private:String?
        var base64Public:String?
        do{
            base64Public = try publicKey?.base64String()
            base64Private = try privateKey?.base64String()
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
    
    
    func encryptAESKey(aesKey : Array<UInt8>)-> Array<UInt8>?{
        do{
                let clear = ClearMessage(data: Data(aesKey))
            let encrypted = try clear.encrypted(with: publicKey!, padding: .OAEP)
                return encrypted.data.bytes
            
        }catch{
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    func decryptAESKey(_ encryptedKey : Data)->Array<UInt8>?{
        
        do{
            let encrypted = EncryptedMessage(data:  encryptedKey)

            let clear = try encrypted.decrypted(with: privateKey!, padding: .OAEP)
                let binary = clear.data.bytes
                return binary
            
     
        }catch{
            print(error.localizedDescription)
        }
        return nil
    }
    
}

//
//  RSAKeyPair.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import Foundation
import SwiftyRSA
class RSAKeyPair{
    
    private var privateKey: PrivateKey? = nil
    private var publicKey : PublicKey? = nil
    
    
    
    
    func CreateRSAKeyPair()->(PrivateKey?,PublicKey?){
        do{
            let keyPair = try SwiftyRSA.generateRSAKeyPair(sizeInBits: 1028)
             privateKey = keyPair.privateKey
             publicKey = keyPair.publicKey
        }catch{
            print(error.localizedDescription)
        }
        return (privateKey,publicKey)
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
    
}

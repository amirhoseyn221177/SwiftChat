//
//  AESKeyModel.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import Foundation
import CryptoSwift
import SwiftyJSON
import Alamofire
import SwiftyRSA

class AESKeyModel{
    private var AESInstance : AES? = nil

    
    private var Iv : Array<UInt8>{
        get{
            return AES.randomIV(AES.blockSize)
        }
    }
    private var AES_key : Array<UInt8>?{
        get{
            if let finalAesKey = createAESKey(){
                return finalAesKey
            }
            return nil
        }
    }
    
    

    private var randomBytePassword : Array<UInt8>?{
        get{
            return generateRandomBytes()
        }
    }
    private var randomSalt : Array<UInt8>? {
        get{
            return generateRandomBytes()
        }
    }
    
    private var encryptedDataBase64 : String? = ""
    
    

    func getIV()-> Array<UInt8>{
        return self.Iv
    }
    
    
    func createAESKey()-> Array<UInt8>? {
  
        do{
            if let rp = randomBytePassword , let rs = randomSalt{
                  let aeskey = try PKCS5.PBKDF2(password: rp, salt: rs, iterations: 4096, keyLength: 32, variant: .sha256).calculate()
                
                AESInstance = try AES(key:aeskey , blockMode: CBC(iv: Iv), padding: .pkcs5)
            return aeskey
            }
        }catch{
            print(error.localizedDescription)
        }
        return nil
        
    }
        
        
    private func generateRandomBytes() -> Array<UInt8>?{
            var keyData = Data(count: 32)
            let result = keyData.withUnsafeMutableBytes{
                       SecRandomCopyBytes(kSecRandomDefault, 32, $0.baseAddress!)
                   }
            if result == errSecSuccess {
                 return keyData.bytes
            }
            return nil
        }
    
    
    func getAESKey()-> Array<UInt8>?{
        return self.AES_key
    }
    
    
    func encryptData(_ message : MessageModel)-> Array<UInt8>?{
        var encrypted : Array<UInt8>? = nil
        do {
            if let byteData : Array<UInt8> = message.textContent?.bytes{
                encrypted = try AESInstance?.encrypt(byteData)
            }else{
                 fatalError("no message to encrypt ")
            }
        }catch{
            print(error.localizedDescription)
        }
        
        print(encrypted!)
        encryptedDataBase64 = encrypted?.toBase64();
        return encrypted
    }
    
    
    func decryptData(_ encryptedData : Array<UInt8>?)-> String?{
        var message : String? = ""
        do{
            let decryptedData = try AESInstance?.decrypt(encryptedData!)
            message = String(decoding: Data(decryptedData!), as: UTF8.self)
        }catch{
            print(error.localizedDescription)
        }
        return message
    }
    

    
//
//    func sendingToBackEnd(){
//        self.createAESKey()
//        self.encryptData("man kheili kioni hastam")
//        let base64IV = Iv?.toBase64()
//        let aesBase64 = AES_key?.toBase64()
//        let data:[String:String]=["text":encryptedDataBase64!,"iv":base64IV!, "key":aesBase64!]
////        let json = JSON(data)
//        AF.request("http://10.0.0.8:8080/user/dec", method: .post, parameters: data,encoder: JSONParameterEncoder.default ).responseJSON { Response in
//            debugPrint(Response)
//        }
//    }
    
}

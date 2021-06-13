import UIKit
import CryptoSwift
var keyData = Data(count: 32)
let result = keyData.withUnsafeMutableBytes{
    SecRandomCopyBytes(kSecRandomDefault, 32, $0.baseAddress!)
}


func generateRandomBytes() -> Array<UInt8>?{
        var keyData = Data(count: 32)
        let result = keyData.withUnsafeMutableBytes{
                   SecRandomCopyBytes(kSecRandomDefault, 32, $0.baseAddress!)
               }
        if result == errSecSuccess {
             return keyData.bytes
        }
        return nil
    }

let key = try PKCS5.PBKDF2(password: generateRandomBytes()!, salt: generateRandomBytes()!, iterations: 4096, keyLength: 32, variant: .sha256).calculate()
let AES_Key = try AES(key:key , blockMode: CBC(iv: AES.randomIV(AES.blockSize)), padding: .pkcs5)

print(AES_Key.keySize)


let data = "ab kose nanat kheili khobe"
let bytedata :Array<UInt8> = data.bytes
let encryprted = try AES_Key.encrypt(bytedata)

let decrypted = try AES_Key.decrypt(encryprted)
let decData = String(decoding: Data(decrypted), as: UTF8.self)
print(decData)



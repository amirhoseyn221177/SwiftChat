//
//  FriendAPI.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-07-11.
//

import Foundation
import UIKit
import RealmSwift
class FriendAPI : Codable {
    var name : String = ""
    var username : String = ""
    var ProfilePhoto : String = ""
    var publicKey : Data?
    var mainUser : String?
    
//    init (friend : Friend){
//        self.name = friend.name
//        self.username = friend.username
//        self.ProfilePhoto = friend.ProfilePhoto
//        self.publicKey = friend.publickey
//        self.mainUser = friend.mainUser.first?.username
//
//    }
//
    
    
    func FetchImage(imageURL : String, completion : @escaping (Result<Data,Error>) -> Void ) {
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: URL(string: imageURL)!) { data, URLResponse, error in
             
             guard let data = data , error == nil else {
                 print(error?.localizedDescription as Any)
                 completion(.failure(error!))
                 return;
             }
        
           
             completion(.success(data))
         }
         task.resume()
        }
        
        }
    
}

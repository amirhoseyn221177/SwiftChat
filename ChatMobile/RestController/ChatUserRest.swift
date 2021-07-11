//
//  ChatUserRest.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-07-11.
//

import Foundation

class UserAPI : Codable {
    var name : String = ""
    var username : String = ""
    var publicKey : Data?
    var password : String = ""
    var friends = [FriendAPI]()
    
   
    
    init (userDB : User){
        self.name = userDB.name
        self.username = userDB.username
        self.publicKey = userDB.publicKey
        self.password = userDB.password
    }
    
}

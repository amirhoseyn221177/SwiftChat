//
//  FriendAPI.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-07-11.
//

import Foundation

class FriendAPI : Codable {
    var name : String = ""
    var username : String = ""
    var ProfilePhoto : String = ""
    var publicKey : Data?
    var mainUser : String?
    
    init (friend : Friend){
        self.name = friend.name
        self.username = friend.username
        self.ProfilePhoto = friend.ProfilePhoto
        self.publicKey = friend.publickey
        self.mainUser = friend.mainUser.first?.username
        
    }
}

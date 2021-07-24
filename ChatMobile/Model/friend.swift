//
//  friend.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-19.
//

import Foundation
import RealmSwift
import SwiftyRSA
import ObjectMapper
class Friend : Object   {
    @objc dynamic var id : String = ""
    @objc dynamic var name : String!
    @objc dynamic var username : String!
    @objc dynamic var ProfilePhotoURL : String = ""
    @objc dynamic var profilePhotoData : Data?
    @objc dynamic var publickey : Data?
    var mainUser = LinkingObjects(fromType : User.self , property:"friends")
    
    
    
    
    
    
}

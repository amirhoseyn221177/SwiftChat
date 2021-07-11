//
//  ChatUser.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-19.
//

import Foundation
import RealmSwift
import SwiftyRSA
class User : Object  {
    @objc dynamic var id : String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var username : String = ""
    @objc dynamic var  publicKey : Data?
    @objc dynamic var password : String = ""
    let friends = List<Friend>()
}

//
//  ChatUser.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-19.
//

import Foundation
import RealmSwift
import SwiftyRSA
class User : Object {
    @objc dynamic var name: String = ""
    @objc dynamic var username : String = ""
    @objc dynamic var  publicKey : Data?
    let friends = List<Friend>()
}

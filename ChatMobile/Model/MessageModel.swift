//
//  MessageModel.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-14.
//

import Foundation
import SwiftyRSA
import RealmSwift

class MessageModel : Object {
    @objc dynamic var textContent : String?
    @objc dynamic var mediaContent : String?
    @objc dynamic var ContentType : String?
    @objc dynamic var sender : String?
    @objc dynamic var reciever : String?
    @objc dynamic var dateTime : Int64 = 0
    @objc dynamic var token : String!
    @objc dynamic var recieverPublicRSAKey : Data?
    @objc dynamic var iv : Data?
}

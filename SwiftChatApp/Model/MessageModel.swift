//
//  MessageModel.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-14.
//

import Foundation
import SwiftyRSA

class MessageModel {
     var textContent : String?
     var mediaContent : String?
     var ContentType : String?
     var sender : String?
     var reciever : String?
     var dateTime : Int64?
     var token : String!
     var recieverPublicRSAKey : PublicKey?
}

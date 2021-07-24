//
//  MessageRest.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-07-24.
//

import Foundation


class MessageRest : Codable {
    var textContent : String?
    var mediaContent : String?
    var contentType : String?
    var sender : String?
    var reciever : String?
    var dateTime : Int64 = 0
    var token : String!
    var recieverPublicRSAKey : Data?
    var iv : Data?
    
    init(messageModel : MessageModel? = MessageModel()) {
        self.textContent = messageModel?.textContent
        mediaContent = messageModel?.mediaContent
        contentType = messageModel?.contentType
        sender = messageModel?.sender
        reciever = messageModel?.reciever
        dateTime = messageModel?.dateTime ?? 0
        token = messageModel?.token
        recieverPublicRSAKey = messageModel?.recieverPublicRSAKey
        iv = messageModel?.iv
    }
}

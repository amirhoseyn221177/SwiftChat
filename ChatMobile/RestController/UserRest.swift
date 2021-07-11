//
//  UserRest.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-07-09.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
class UserRest {
    
    var user : User?
    
    init(user : User) {
        self.user = user
    }
    
    
    func createUser(){
        let data = UserAPI(userDB: user!)
        AF.request("http://10.0.0.8:8080/user/register", method: .post, parameters: data, encoder: JSONParameterEncoder.default).responseJSON { Response in
            switch (Response.result){
            case .success( let value):
                print(JSON(value)["name"])
            case .failure(_):
                print("sheet")
            }
            
        }
    }
}

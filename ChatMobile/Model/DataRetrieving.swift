//
//  DataRetrieving.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-06-28.
//

import Foundation
import RealmSwift
class DataRetrieving {
    var realm : Realm? {
        get{
            do{
                return try Realm()
            }catch{
                print(error.localizedDescription)
            }
            return nil
        }
    }
    var user : User
    init(user : User) {
        self.user = user
    }
    
    
    func createUser(){
           try! realm?.write {
                realm?.add(user)
            }
    }
    
    
    func getUser(username : String)-> User?{
        let scope =  realm?.objects(User.self).filter("username ==%@",username)
        return scope?.first
    }
    
}

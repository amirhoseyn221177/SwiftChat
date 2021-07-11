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
  
    
    
    func createFriend(friend : Friend,user : User){
           try! realm?.write {
                realm?.add(friend)
                realm?.add(user)
            }
    }
    
    func createUser (user : User){
        try! realm?.write({
            realm?.add(user)
        })
    }
    
    
    func getFriend(username : String)-> Friend?{
        let scope =  realm?.objects(Friend.self).filter("username ==%@",username)
        return scope?.first
    }
    
    func getAllFriends(mainUser : String)->Results<Friend>?{
        let scope = realm?.objects(Friend.self).filter("ANY mainUser.username ==%@" , mainUser)
        return scope
    }
    
    func getUser ()-> User?{
        let scope = realm?.objects(User.self)
        return scope?.first
    }
    
}

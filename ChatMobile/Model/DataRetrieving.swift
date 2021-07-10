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
  
    
    
    func createUser(friend : Friend){
           try! realm?.write {
                realm?.add(friend)
            }
    }
    
    
    func getUser(username : String)-> Friend?{
        let scope =  realm?.objects(Friend.self).filter("username ==%@",username)
        return scope?.first
    }
    
    func getAllUser()->Results<Friend>?{
        let scope = realm?.objects(Friend.self)
        return scope
    }
    
}

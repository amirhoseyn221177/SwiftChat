//
//  FriendsView.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-22.
//

import UIKit
import RealmSwift
class FriendsView: UIViewController ,UITableViewDelegate {

    @IBOutlet weak var friendsTable: UITableView!
    
    
    var allFriends : Results<Friend>?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        friendsTable.delegate = self
        friendsTable.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: "friendCell")
        friendsTable.dataSource = self
        friendsTable.separatorStyle = .singleLine
//        createDummyUsers()
//        getAllTheFriends()

    }
    
    
//
//        func createDummyUsers(){
//            let user = User()
//            user.name = "Amir hoseyn"
//            user.username = "amir2211"
//            let dataRet = DataRetrieving()
//
//            let friend1 = Friend()
//            friend1.name = "arshia"
//            friend1.username = "arshizz"
//            friend1.ProfilePhoto = ""
//            user.friends.append(friend1)
//
//
//            let friend2 = Friend()
//            friend2.name = "ali"
//            friend2.username = "alin"
//            friend2.ProfilePhoto = ""
//            user.friends.append(friend2)
//
//            let friend3 = Friend()
//            friend3.name = "ali"
//            friend3.username = "alig"
//            friend3.ProfilePhoto = ""
//            user.friends.append(friend3)
//
//            let friend4 = Friend()
//            friend4.name = "ali"
//            friend4.username = "alir"
//            friend4.ProfilePhoto = ""
//            user.friends.append(friend4)
//
//            let friend5 = Friend()
//            friend5.name = "sina"
//            friend5.username = "naziri"
//            friend5.ProfilePhoto = ""
//            user.friends.append(friend5)
//
//            let friend6 = Friend()
//            friend6.name = "sara"
//            friend6.username = "mame"
//            friend6.ProfilePhoto = ""
//            user.friends.append(friend6)
//
//            let friend7 = Friend()
//            friend7.name = "toktam"
//            friend7.username = "tits"
//            friend7.ProfilePhoto = ""
//            user.friends.append(friend7)
//
//            let friend8 = Friend()
//            friend8.name = "parmis"
//            friend8.username = "fat"
//            friend8.ProfilePhoto = ""
//            user.friends.append(friend8)
//
//            let friend9 = Friend()
//            friend9.name = "elizabeth"
//            friend9.username = "bitch"
//            friend9.ProfilePhoto = ""
//            user.friends.append(friend9)
//
//            let friend10 = Friend()
//            friend10.name = "romina"
//            friend10.username = "head"
//            friend10.ProfilePhoto = ""
//            user.friends.append(friend10)
//            let allfriends = [friend1,friend2,friend3,friend4,friend5,friend6,friend7,friend8,friend9,friend10]
//            for i in 0...9 {
//                dataRet.createUser(friend: allfriends[i],user: user)
//            }
//
//
//    }

    
//
//    func getAllTheFriends (){
//        let dataRet = DataRetrieving()
//        let user = dataRet.getUser(username: "amir2211")
//        allFriends = dataRet.getAllFriends(mainUser: user!.username)
//        DispatchQueue.main.async {
//            self.friendsTable.reloadData()
//        }
//    }
    
    
    

    
 

}



extension FriendsView : UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFriends?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsCell
        let friend = allFriends?[indexPath.row]
        cell.friendCell.text = friend?.username ?? "ab nigger"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MessageView", sender: allFriends?[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageView" {
            let  ttv = segue.destination as! TextTestView
            let friend = Friend()
            let chosen = sender as! Friend
            print(chosen)
            friend.name = chosen.name
            friend.username = chosen.username
            ttv.friend = friend
        }
    }
    

    
    
    
    
    
}

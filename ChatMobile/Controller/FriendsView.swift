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
    let friendAPI = FriendAPI()
    let dataRet = DataRetrieving()
    var user : User?{
        didSet{
            navigationItem.title = user?.username ?? "no user"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        friendsTable.delegate = self
        friendsTable.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: "friendCell")
        friendsTable.dataSource = self
        friendsTable.separatorStyle = .singleLine
        navigationItem.backButtonTitle = "Back"

//        createDummyUsers()
        getaAllFriends()

    }
    
    func getaAllFriends(){
            self.allFriends = self.dataRet.getAllFriends(mainUser: "amir2211")
    }
    

////
//        func createDummyUsers(){
//            let realm = try? Realm()
//            let user = User()
//            user.name = "Amir hoseyn"
//            user.username = "amir2211"
//
//            let friend1 = Friend()
//            friend1.name = "arshia"
//            friend1.username = "arshizz"
//            friend1.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend1)
//
//
//            let friend2 = Friend()
//            friend2.name = "ali"
//            friend2.username = "alin"
//            friend2.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend2)
//
//            let friend3 = Friend()
//            friend3.name = "ali"
//            friend3.username = "alig"
//            friend3.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend3)
//
//            let friend4 = Friend()
//            friend4.name = "ali"
//            friend4.username = "alir"
//            friend4.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend4)
//
//            let friend5 = Friend()
//            friend5.name = "sina"
//            friend5.username = "naziri"
//            friend5.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend5)
//
//            let friend6 = Friend()
//            friend6.name = "sara"
//            friend6.username = "mame"
//            friend6.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend6)
//
//            let friend7 = Friend()
//            friend7.name = "toktam"
//            friend7.username = "tits"
//            friend7.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend7)
//
//            let friend8 = Friend()
//            friend8.name = "parmis"
//            friend8.username = "fat"
//            friend8.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend8)
//
//            let friend9 = Friend()
//            friend9.name = "elizabeth"
//            friend9.username = "bitch"
//            friend9.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend9)
//
//            let friend10 = Friend()
//            friend10.name = "romina"
//            friend10.username = "head"
//            friend10.ProfilePhotoURL = "https://cdn.mos.cms.futurecdn.net/JosmaeqtypHvTB25JQC3q9-970-80.jpg.webp"
//            user.friends.append(friend10)
//            let allfriends = [friend1,friend2,friend3,friend4,friend5,friend6,friend7,friend8,friend9,friend10]
//            for i in 0...9 {
//                dataRet.createFriend(friend: allfriends[i],user: user)
//            }
//
//
//    }
//
    
     
    }


extension FriendsView : UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFriends?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsCell
        let friend = allFriends?[indexPath.row]
        if friend?.profilePhotoData != nil{
            cell.updateTheImageView(imageData: friend?.profilePhotoData)

        }
        cell.friendCell.text = friend?.username ?? "ab"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(137)
        performSegue(withIdentifier: "MessageView", sender: allFriends?[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageView" {
            let  ttv = segue.destination as! TextTestView
            let friend = Friend()
            let chosen = sender as! Friend
            friend.name = chosen.name
            friend.username = chosen.username
            ttv.friend = friend
        }
    }
    
    
    
    

    
    
    
    
    
}

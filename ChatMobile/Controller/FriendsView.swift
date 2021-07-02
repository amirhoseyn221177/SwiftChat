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
    
    
    var allFriends : Results<friend>?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        friendsTable.delegate = self
        friendsTable.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: "friendCell")
        friendsTable.dataSource = self

    }
    
    
   
    
    
    

    
 

}



extension FriendsView : UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFriends?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsCell
        
        cell.friendCell.text = "abdullah"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MessageView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageView" {
            let  ttv = segue.destination as! TextTestView
            let user = User()
            user.name = "Amir"
            user.username = "amir2211"
            ttv.user = user
        }
    }
    

    
    
    
    
    
}

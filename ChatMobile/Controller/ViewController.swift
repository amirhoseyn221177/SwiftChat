//
//  ViewController.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import UIKit
import RealmSwift

class ViewController: UIViewController{

    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var usernameTextinput: UITextField!
    let dateRet  = DataRetrieving()
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginUser()
    }
    @IBAction func settinUsername(_ sender: Any) {
        user  = User()
        user?.name = nameInput.text!
        user?.username = usernameTextinput.text!
        user?.password = passwordInput.text!
        print(user)
        let userRest = UserRest(user: user!)
        dateRet.createUser(user: user!)
    }
    
    func loginUser(){
         user = dateRet.getUser()
        print(user)
        if user == nil{
            let alert = UIAlertController(title: "sheeet", message: "aint no user found  damn ", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                alert.dismiss(animated: true, completion: nil)

            }
        }
        performSegue(withIdentifier: "friends", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friends"{
            let friendView = segue.destination as! FriendsView
            friendView.user = user
            
        }
    }
    
    
    }






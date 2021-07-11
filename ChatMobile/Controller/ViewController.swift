//
//  ViewController.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-12.
//

import UIKit

class ViewController: UIViewController{

    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var usernameTextinput: UITextField!
    let dateRet  = DataRetrieving()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginUser()
    }
    @IBAction func settinUsername(_ sender: Any) {
        let user  = User()
        user.name = nameInput.text!
        user.username = usernameTextinput.text!
        user.password = passwordInput.text!
        let userRest = UserRest(user: user)
        userRest.createUser()
    }
    
    func loginUser(){
        let mainUser = dateRet.getUser()
        if mainUser == nil{
            let alert = UIAlertController(title: "sheeet", message: "aint no user found  damn ", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                alert.dismiss(animated: true, completion: nil)

            }
        }
//        performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    }


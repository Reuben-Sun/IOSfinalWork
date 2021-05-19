//
//  LoginViewController.swift
//  NewsApp
//
//  Created by 孙政 on 2021/5/19.
//

import UIKit

class LoginViewController: UIViewController {

    let defaults = UserDefaults.standard
    let nameKey = "Name"
    let passwordKey = "Password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    jumpToMain()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let name = nameText.text!
        let password = passwordText.text!
        
        defaults.set(name, forKey: nameKey)
        defaults.set(password, forKey: passwordKey)
        
        jumpToMain()
        
    }
    func jumpToMain(){
        let name_pre = defaults.string(forKey: nameKey)!
        let password_pre = defaults.string(forKey: passwordKey)!
        
        if name_pre == "2019302110177" && password_pre == "123456"{
            
            
            let mainBoard:UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
            let VCMain = mainBoard!.instantiateViewController(withIdentifier: "vcMain")
            UIApplication.shared.windows[0].rootViewController = VCMain
        }
        else{
            passwordText.text = nil
            passwordText.placeholder = "账号或密码错误！"
        }
        
        
    }
    

}

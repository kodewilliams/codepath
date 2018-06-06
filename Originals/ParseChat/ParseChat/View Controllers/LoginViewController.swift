//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Kode Williams on 2/25/18.
//  Copyright © 2018 Kode Williams. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let alertController = UIAlertController(title: "Error", message: "One or more empty field(s).", preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default)
    
    func validateInput() -> Bool {
        if usernameTextField.text == "" || passwordTextField.text == "" {
            present(alertController, animated: true)
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let valid = validateInput()
        if !valid {
            return
        }
        
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                let signupAlertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                signupAlertController.addAction(OKAction)
            } else {
                print("User registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let valid = validateInput()
        if !valid {
            return
        }
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                let loginAlertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                loginAlertController.addAction(OKAction)
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        alertController.addAction(OKAction)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

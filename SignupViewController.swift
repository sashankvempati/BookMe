//
//  SignupViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.borderColor = UIColor(red: 0/255.0, green: 168/255.0, blue: 232/255.0, alpha: 1).cgColor
        loginButton.layer.borderWidth = 4
        loginButton.layer.cornerRadius = 5
        signupButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true);
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        guard let name = nameField.text else {return}
        guard let email = emailField.text else {return}
        guard let phoneNumber = phoneNumberField.text else {return}
        
        if passwordField.text != confirmPassword.text {
            
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Save the profile data to Firebase Database
                    self.saveProfile(name: name, email: email, phoneNumber: phoneNumber) { success in
                        if success {
                            //self.dismiss(animated: true, completion: nil)
                        }
                    }
                    self.performSegue(withIdentifier: "signupSegue", sender: self)
                }
                
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func saveProfile(name:String, email:String, phoneNumber:String, completion: @escaping ((_ success: Bool)->())){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "name":name,
            "email":email,
            "phoneNumber": phoneNumber
            ] as [String:Any]
        
        databaseRef.setValue(userObject){ error, ref in
            completion(error == nil)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

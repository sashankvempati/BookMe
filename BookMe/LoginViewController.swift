//
//  LoginViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel, Kunal Agarwal, and Sashank Vempati on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //tap gesture recognizer
    @IBAction func onTap(_ sender: Any) {
        //if user taps outside textfield, keyboard minimizes
        self.view.endEditing(true);
    }
    override func viewDidAppear(_ animated: Bool){
        //shows the Login View
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            //Moves to next screen if satisfied
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        
        //creates a border around 'Create an Account' button
        createButton.layer.borderColor = UIColor(red: 255/255.0, green: 104/255.0, blue: 63/255.0, alpha: 1).cgColor
        createButton.layer.borderWidth = 4
        createButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        
        
    }

    @IBAction func onSignIn(_ sender: Any) {
        //Authenticates user when logging in
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error == nil{
                //Key identifier- "loginSegue" 
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
                //displays error popup if login unsuccessful
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
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

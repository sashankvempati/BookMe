//
//  SignupViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel, Kunal Agarwal, and Sashank Vempati on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        //border around login button with dimension values of corners
        loginButton.layer.borderColor = UIColor(red: 0/255.0, green: 168/255.0, blue: 232/255.0, alpha: 1).cgColor
        loginButton.layer.borderWidth = 4
        loginButton.layer.cornerRadius = 5
        signupButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTap(_ sender: Any) {
        //keyboard is minimized when tapped outside
        self.view.endEditing(true)
    }
    @IBAction func onSignUp(_ sender: Any) {
        if passwordField.text != confirmPassword.text {
            //displays pop up error if both passwords do not match
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            //name of the button
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            //pop up disappears
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else {
            Auth.auth()
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                
                if error == nil {
                    //Key identifier- "signupSegue"
                    self.performSegue(withIdentifier: "signupSegue", sender: self)
                }
                
                else{
                    //Displays a pop up error message
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    //When the "OK" button is pressed, the popup
                    //message disappears
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
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

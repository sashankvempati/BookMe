//
//  SettingsViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel, Kunal Agarwal, and Sashank Vempati on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var changeprofileButton: UIButton!
    @IBOutlet weak var addpaymentButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var cards = [Int]()
    
    @IBOutlet weak var payTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payTableView.delegate = self
        payTableView.dataSource = self
        
        cards = [1,2,3,4,5,6,7,8]

        addpaymentButton.layer.borderWidth = 1
        changeprofileButton.layer.borderWidth = 1
        addpaymentButton.layer.cornerRadius = 5
        changeprofileButton.layer.cornerRadius = 5
        addpaymentButton.layer.borderColor = UIColor(red: 48/255, green: 48/255, blue: 54/255, alpha: 1.0).cgColor
        addpaymentButton.layer.borderColor = UIColor(red: 48/255, green: 48/255, blue: 54/255, alpha: 1.0).cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onChangeProfile(_ sender: Any) {
    }
    
    @IBAction func addPayment(_ sender: Any) {
    }
    @IBAction func onLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = payTableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        }
        return cell
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

//
//  AddPaymentViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit


class AddPaymentViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var monthField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    
    var card = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.array(forKey: "cards") == nil){
        UserDefaults.standard.set([], forKey: "cards")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onFinish(_ sender: UIButton) {
        card["name"] = nameField.text!
        card["number"] = cardNumberField.text!
        card["expiry"] = monthField.text!+"/"+yearField.text!
        card["cvv"] = cvvField.text!
        card["zip"] = zipCodeField.text!
        var cards = UserDefaults.standard.array(forKey: "cards")
        cards?.append(card)
        UserDefaults.standard.set(cards, forKey: "cards")
        self.performSegue(withIdentifier: "finishSegue", sender: self)
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

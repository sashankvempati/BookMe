//
//  ConfirmationViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    

    @IBOutlet weak var BILLvIEW: UIView!
    @IBOutlet weak var chargeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var serviceChargeLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var roomImage: UIImageView!
    
    var roomList = [PostModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let room: PostModel
        room = roomList[0]
        
        BILLvIEW.layer.cornerRadius = 5
        BILLvIEW.layer.masksToBounds = true
        
        addressLabel.text = room.location
        hostLabel.text = room.postedBy
        rateLabel.text = room.rate
        availableLabel.text = room.availability
        totalTimeLabel.text = "1 hour"
        serviceChargeLabel.text = "1.00"
        
        
        let charge = Double(rateLabel.text!) ?? 0
        chargeLabel.text = "\(charge)"
        
        let service = Double(serviceChargeLabel.text!) ?? 0
        let tax = round((charge + service) * 5)/100
        taxLabel.text = "\(tax)"
        
        let total = tax + charge + service
        totalLabel.text = "\(total)"
        
        let imgStr = room.imageRoom
        
        let url = URL(string: String(format:"data:application/octet-stream;base64,%@",imgStr ?? ""))
        do {
            let data =  try Data(contentsOf: url!)
            roomImage.image = UIImage(data: data)
        }catch {
            
        }
        

        // Do any additional setup after loading the view.
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let segueID = segue.identifier
        if(segueID! == "doneSegue") {
            //Find the selected room
            // let cell = sender as! UITableViewCell
            // let indexPath = tableView.indexPath(for: cell)!
            let room = roomList[0]
            
            //Pass the selected room to the details view controller
            if let confirmationViewController = segue.destination as! UINavigationController,
                let editContactViewController = confirmationViewController.viewControllers.first {
            editContactViewController = [room]
            
            //tableView.deselectRow(at: indexPath, animated: true)
        }
    }
        
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let room = roomList[0]
        if let navigationController = segue.destination as? UINavigationController,
            let editContactViewController = navigationController.viewControllers.first as? ReservedTableViewController {
            editContactViewController.roomList = [room]
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

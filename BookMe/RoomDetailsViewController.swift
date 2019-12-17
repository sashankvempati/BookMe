//
//  RoomDetailsViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel, Kunal Agarwal, and Sashank Vempati on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit

class RoomDetailsViewController: UIViewController {
    @IBOutlet weak var hostNameLabel: UILabel!
    
    @IBOutlet weak var amenitiesCollectionView: UICollectionView!
    @IBOutlet weak var availableTimeLabel: UILabel!
    @IBOutlet weak var hostDescriptionLabel: UILabel!
    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var hostImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var roomImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onBook(_ sender: Any) {
        // Add this listing to the "reserved rooms" tab
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

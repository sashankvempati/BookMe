//
//  AvailableRoomsViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel, Kunal Agarwal, and Sashank Vempati on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit

class AvailableRoomsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //each room is showed as a listing
    @IBOutlet weak var tableView: UITableView!
    var rooms = [Int]()
    
    //search bar for picking a time
    @IBOutlet weak var timeField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
rooms = [1,2,3,4,5,6]
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //returns number of rooms available
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Each listing in the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath) as! RoomsCell
        
        //alternates the color of each listing
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

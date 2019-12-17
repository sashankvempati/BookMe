//
//  ReservedTableViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreLocation

class ReservedTableViewController: UITableViewController {
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    let locationManager = CLLocationManager()
    
    var longVal = Double()
    var latVal = Double()
    
    var roomList = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        tableView.dataSource = self
        tableView.delegate = self
        
        //let room = roomList[0]
        
        ref = Database.database().reference()
        
        let refRooms = Database.database().reference().child("users").child("posts")
        
        refRooms.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.roomList.removeAll()
                
                for rooms in snapshot.children.allObjects as! [DataSnapshot] {
                    let roomObject = rooms.value as? [String: AnyObject]
                    let roomLocation = roomObject?["location"]
                    let roomRate = roomObject?["rate"]
                    let roomAvailability = roomObject?["availability"]
                    let roomAmenities = roomObject?["amenities"]
                    let roomLat = roomObject?["lat"]
                    let roomLong = roomObject?["long"]
                    let roomReserved = roomObject?["reservedBy"]
                    let roomPosted = roomObject?["postedBy"]
                    let roomImage = roomObject?["imageRoom"]
                    
                    
                    
                    let room  = PostModel(location: roomLocation as! String?, rate: roomRate as! String?, availability: roomAvailability as! String?, amenities: roomAmenities as? [String] ?? [], lat: roomLat as! Double?, long: roomLong as! Double?, reservedBy: roomReserved as! String?, postedBy: roomPosted as! String?, imageRoom: roomImage as! String?)
                    
                    if(room.reservedBy != "No one"){
                        self.roomList.append(room)
                        print(room.reservedBy!+" RESERVED ")
                    }
                }
                self.tableView.reloadData()
            }
        })

        
        
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
           // locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latVal = locValue.latitude
        longVal = locValue.longitude
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return roomList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservedCell", for: indexPath) as! ReservedCell
        
        let room: PostModel
        
        room = roomList[indexPath.row]
        
        cell.rateLabel.text = "$"+room.rate! + "/hr"
        cell.timeLabel.text = room.availability
        
        if room.lat != nil
        {
            let lat = room.lat
            let long = room.long
            
            //let lat = Double(rooms[indexPath.row]["lat"]!)
            // let long = Double(rooms[indexPath.row]["long"]!)
            
            
            let coordinate1 = CLLocation(latitude: lat!, longitude: long!)
            
            let coordinate0 = CLLocation(latitude: latVal, longitude: longVal)
            
            let distanceInMeters = coordinate0.distance(from: coordinate1)
            cell.distanceLabel.text = "\(round(distanceInMeters/16.0934)/100) miles"
            
        }
        else{
            cell.distanceLabel.text = "unknown"
        }
        
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(red: 255.0/255, green: 104.0/255, blue: 63.0/255, alpha: 0.08)
        } else {
            cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let segueID = segue.identifier
        if(segueID! == "secondDetailsSegue") {
            //Find the selected room
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let room = roomList[indexPath.row]
            
            //Pass the selected room to the details view controller
            let detailsViewController = segue.destination as! SecondConfirmationViewController
            detailsViewController.roomList = [room]
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

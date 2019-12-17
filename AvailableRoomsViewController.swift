//
//  AvailableRoomsViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreLocation

class AvailableRoomsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

   
    
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var longVal = Double()
    var latVal = Double()
    
    let datePicker = UIDatePicker()
    
    let locationManager = CLLocationManager()
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var roomList = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
                    //self.tableView.reloadData()
                    if(room.reservedBy == "No one"){
                        self.roomList.append(room)
                        print(room.reservedBy!+" AVAILIABLE ")
                    }
                }
                self.tableView.reloadData()
            }
        })
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        
        showDatePicker()
    }
    
    @IBAction func createPost(_ sender: Any) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latVal = locValue.latitude
        longVal = locValue.longitude
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        timeField.inputAccessoryView = toolbar
        timeField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        timeField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return rooms.count
        return roomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath) as! RoomsCell
        
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
            cell.distLabel.text = "\(round(distanceInMeters/16.0934)/100) miles"

        }
        else{
             cell.distLabel.text = "unknown"
        }
        
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 0, green: 168.0/255, blue: 232.0/255, alpha: 0.07)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let segueID = segue.identifier
        if(segueID! == "detailsSegue") {
        //Find the selected room
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let room = roomList[indexPath.row]
        
        //Pass the selected room to the details view controller
        let detailsViewController = segue.destination as! RoomDetailsViewController
        detailsViewController.roomList = [room]
        
        tableView.deselectRow(at: indexPath, animated: true)
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

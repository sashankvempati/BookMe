//
//  RoomDetailsViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/2/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RoomDetailsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var amenitiesCollectionView: UICollectionView!
    @IBOutlet weak var availableTimeLabel: UILabel!
    @IBOutlet weak var hostDescriptionLabel: UILabel!
    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var hostImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var roomImageView: UIImageView!
    
    @IBOutlet weak var bookButton: UIButton!
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var roomList = [PostModel]()
    
    //var room: PostModel
    
    var amenities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookButton.layer.cornerRadius = 5
        //ref = Database.database().reference()
        //let refRooms = Database.database().reference().child("users").child("posts")
        
        amenitiesCollectionView.delegate = self
        amenitiesCollectionView.dataSource = self
        
        let room: PostModel
        
        room = roomList[0]
        
        rateLabel.text = "$" + room.rate! + "/hr"
        rateLabel.layer.cornerRadius = 5
        rateLabel.layer.masksToBounds = true

        availableTimeLabel.text = room.availability
        
        locationLabel.text = room.location
        hostNameLabel.text = room.postedBy

        amenities = room.amenities
        
        let imgStr = room.imageRoom
        
        let url = URL(string: String(format:"data:application/octet-stream;base64,%@",imgStr ?? ""))
        do {
            let data =  try Data(contentsOf: url!)
            roomImageView.image = UIImage(data: data)
        }catch {
            
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(amenities.count)
        return amenities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenityCell", for: indexPath) as! AmenityCell
        let amenity = amenities[indexPath.item]
        cell.amenityImageView.image = UIImage(named: amenity)
        return cell
    }
    

    @IBAction func onBook(_ sender: Any) {
        let room: PostModel
        room = roomList[0]
        self.savePost(location: room.location!, rate: room.rate!, amenities: room.amenities, availability: room.availability!, lat: room.lat!, long: room.long!, reservedBy: Auth.auth().currentUser?.displayName ?? "user", postedBy: room.postedBy!, imageRoom: room.imageRoom!) { success in
            if success {
                self.performSegue(withIdentifier: "confirmSegue", sender: self)
            }
        }
    }
    
    func savePost(location:String, rate:String, amenities:[String], availability:String, lat:Double, long:Double, reservedBy: String?, postedBy: String?, imageRoom: String?, completion: @escaping ((_ success: Bool)->()) ){
        guard let uPost = Auth.auth().currentUser?.uid else {return}
        let databasePostRef = Database.database().reference().child("users/posts/\(uPost)")
        
        let userObject = [
            "location":location,
            "rate":rate,
            "amenities": amenities,
            "availability":availability,
            "lat":lat,
            "long":long,
            "reservedBy":reservedBy,
            "postedBy":postedBy,
            "imageRoom": imageRoom
            ] as [String:Any]
        
        databasePostRef.setValue(userObject){ error, ref in
            completion(error == nil)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let segueID = segue.identifier
        if(segueID! == "confirmSegue") {
            //Find the selected room
           // let cell = sender as! UITableViewCell
           // let indexPath = tableView.indexPath(for: cell)!
            let room = roomList[0]
            
            //Pass the selected room to the details view controller
            let confirmationViewController = segue.destination as! ConfirmationViewController
            confirmationViewController.roomList = [room]
            
            //tableView.deselectRow(at: indexPath, animated: true)
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

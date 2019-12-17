//
//  postRoomViewController.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/16/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase
import FirebaseAuth


class postRoomViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var longitudeField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var amenitiesField: UITextField!
    @IBOutlet weak var rateField: UITextField!
    @IBOutlet weak var avaiableField: UITextField!
    @IBOutlet weak var roomImage: UIImageView!
    
    var amenities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amenities = []
        roomImage.image = UIImage(named: "placeholder")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onImageTap(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        roomImage.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPost(_ sender: Any) {
        
        guard let location = locationField.text else {return}
        guard let rate = rateField.text else {return}
        //guard let amenities = amenitiesField.text else {return}
        guard let availability = avaiableField.text else {return}
        
        guard let img = roomImage.image else {return}
        
        
        let image = (img.pngData()?.base64EncodedString()) as! String
        
        let lat = latitudeField.text ?? "0.0"
        let long = longitudeField.text ?? "0.0"
        
        let postedBy = Auth.auth().currentUser?.displayName ?? "Host"
        /*
        let user = Auth.auth().currentUser
        if let user = user {
            postedBy = user.displayName!
        }
        */
        //let userID : String = (Auth.auth().currentUser?.uid)!

        /*
        guard let uid = Auth.auth().currentUser?.uid else {return}
        print("here is the user" + "\(uid)")
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        databaseRef.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                //self.roomList.removeAll()
                
                for users in snapshot.children.allObjects as! [DataSnapshot] {
                    let userObject = users.value as? [String: AnyObject]
                    postedBy = userObject?["name"] as! String
                }
            }
        }
        */
        
        /** check to make sure all the slots have been filled **/
        /** If everything works successfully when Post button is clicked **/
        self.savePost(location: location, rate: rate, amenities: amenities, availability: availability, lat: Double(lat) ?? 0.0, long: Double(long) ?? 0.0, reservedBy: "No one", postedBy: postedBy, imageRoom: image) { success in
            if success {
                
            }
        }
        self.dismiss(animated: true, completion: nil)
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func acSwitch(_ sender: UISwitch) {
        if sender.isOn && !amenities.contains("ACSym")
        {
            amenities.append("ACSym")
        }
        else if !sender.isOn && amenities.contains("ACSym")
        {
            amenities.remove(at: amenities.firstIndex(of: "ACSym")!)
        }
    }
    @IBAction func wifiSwitch(_ sender: UISwitch) {
        if sender.isOn && !amenities.contains("WifiSym")
        {
            amenities.append("WifiSym")
        }
        else if !sender.isOn && amenities.contains("WifiSym")
        {
            amenities.remove(at: amenities.firstIndex(of: "WifiSym")!)
        }
    }
    @IBAction func compSwitch(_ sender: UISwitch) {
        if sender.isOn && !amenities.contains("ComputerSym")
        {
            amenities.append("ComputerSym")
        }
        else if !sender.isOn && amenities.contains("ComputerSym")
        {
            amenities.remove(at: amenities.firstIndex(of: "ComputerSym")!)
        }
    }
    @IBAction func waterSwitch(_ sender: UISwitch) {
        if sender.isOn && !amenities.contains("WaterSym")
        {
            amenities.append("WaterSym")
        }
        else if !sender.isOn && amenities.contains("WaterSym")
        {
            amenities.remove(at: amenities.firstIndex(of: "WaterSym")!)
        }
    }
    @IBAction func outletSwitch(_ sender: UISwitch) {
        if sender.isOn && !amenities.contains("OutletSym")
        {
            amenities.append("OutletSym")
        }
        else if !sender.isOn && amenities.contains("OutletSym")
        {
            amenities.remove(at: amenities.firstIndex(of: "OutletSym")!)
        }
    }
    @IBAction func stationarySwitch(_ sender: UISwitch) {
        if sender.isOn && !amenities.contains("StationarySym")
        {
            amenities.append("StationarySym")
        }
        else if !sender.isOn && amenities.contains("StationarySym")
        {
            amenities.remove(at: amenities.firstIndex(of: "StationarySym")!)
        }
    }
    @IBAction func lightSwitch(_ sender: UISwitch) {
        if sender.isOn && !amenities.contains("SunSym")
        {
            amenities.append("SunSym")
        }
        else if !sender.isOn && amenities.contains("SunSym")
        {
            amenities.remove(at: amenities.firstIndex(of: "SunSym")!)
        }
    }
}

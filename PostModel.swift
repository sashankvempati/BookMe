
//  PostModel.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/21/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit

class PostModel {

    var location: String?
    var rate: String?
    var availability: String?
    var amenities = [String]()
    var lat: Double?
    var long: Double?
    var reservedBy: String?
    var postedBy: String?
    var imageRoom: String?
    //var hostImage: String?
    
    init(location:String?, rate:String?, availability: String?, amenities:[String], lat:Double?, long:Double?, reservedBy:String?, postedBy:String?, imageRoom:String?) {
        self.location = location;
        self.rate = rate;
        self.availability = availability;
        self.amenities = amenities;
        self.lat = lat;
        self.long = long;
        self.reservedBy = reservedBy;
        self.postedBy = postedBy;
        self.imageRoom = imageRoom;
        //self.hostImage = hostImage;
    }
}

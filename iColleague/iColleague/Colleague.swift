//
//  Colleague.swift
//  iColleague
//
//  Created by Group7 on 10/13/16.
//  Copyright © 2016 Group7. All rights reserved.
//

import UIKit

class Colleague: NSObject{
    var name: String
    var position: String
    var phone: String
    let longitude: Double
    let latitude: Double
    
    init(name: String, position: String, phone: String, longitude: Double, latitude: Double) {
        self.name = name
        self.position = position
        self.phone = phone
        self.longitude = longitude
        self.latitude = latitude
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            
            // Name Array
            let firstNames = ["Joe", "Chris", "Lois", "Meg", "Dan", "Francisco", "Peter", "Glenn", "Cleveland", "Stewie", "Brian"]
            let lastNames = ["Smith", "Swanson", "Doe", "William", "Quagmire", "Griffin", "Brown", "Green", "Ford", "Eastwood"]
            
            // Position Array
            let positions = ["Manager", "Administrator", "DB Manager", "Employee", "Assistant Manager", "Project Manager", "Team Member", "Janitor"]
            
            // Random First Name
            var idx = arc4random_uniform(UInt32(firstNames.count))
            let randomfirstName = firstNames[Int(idx)]
            
            // Random Last Name
            idx = arc4random_uniform(UInt32(lastNames.count))
            let randomlastName = lastNames[Int(idx)]
            
            let randomName = "\(randomfirstName) \(randomlastName)"
            
            // Random Postion
            idx = arc4random_uniform(UInt32(lastNames.count))
            let randomPosition = positions[Int(idx)]
            
            // Random Phone Number
            let randomValue = Int(arc4random_uniform(44444)) + 55555
            
            let randomValue2 = Int(arc4random_uniform(44444)) + 55555
            
            let randPhoneNum = (String(randomValue) + String(randomValue2))
            //let randomSerialNumber =
                //NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            
            self.init(name: randomName,
                      position: randomPosition,
                      phone: randPhoneNum,
                      longitude: 00.00,
                      latitude: 00.00)
        }
        else {
            self.init(name: "", position: "", phone: "", longitude: 00.00, latitude: 00.00)
        }
    }
}

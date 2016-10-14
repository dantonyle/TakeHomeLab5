//
//  ColleagueStore.swift
//  iColleague
//
//  Created by Group7 on 10/13/16.
//  Copyright © 2016 Group7. All rights reserved.
//

import Foundation

class ColleagueStore {
    
    var allColleague = [Colleague]()
    
    init() {
        for _ in 0..<5 {
            createColleague()
        }
    }
    
    func createColleague() -> Colleague {
        let newItem = Colleague(random: true)
        
        allColleague.append(newItem)
        
        return newItem
    }
    
    // delete item from backend
    func removeItem(item: Colleague) {
        if let index = allColleague.indexOf(item) {
            allColleague.removeAtIndex(index)
        }
    }
    
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can re-insert it
        // copy the item at that index
        let movedItem = allColleague[fromIndex]
        
        // Remove item from array
        // delete the original item
        allColleague.removeAtIndex(fromIndex)
        
        // Insert item in array at new location
        allColleague.insert(movedItem, atIndex: toIndex)
    }
}

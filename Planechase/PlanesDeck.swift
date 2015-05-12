//
//  PlanesDeck.swift
//  Planechase
//
//  Created by Aaron Baker on 5/11/15.
//  Copyright (c) 2015 Aaron Baker. All rights reserved.
//

import Foundation

class PlanesDeck {
    var planes: [PlaneCard]
    
    var cardCount: Int {
        return planes.count
    }
    
    init() {
        planes = [
            PlaneCard(name: "Academy at Tolaria West", imageName: "academy_at_tolaria_west"),
            PlaneCard(name: "Cliffside Market", imageName: "cliffside_market"),
            PlaneCard(name: "Lethe Lake", imageName: "lethe_lake"),
            PlaneCard(name: "Llanowar", imageName: "llanowar"),
            PlaneCard(name: "Minamo", imageName: "minamo"),
            PlaneCard(name: "Reality Shaping", imageName: "reality_shaping"),
            PlaneCard(name: "The Fourth Sphere", imageName: "the_fourth_sphere"),
            PlaneCard(name: "Windriddle Palaces", imageName: "windriddle_palaces")
        ]
    }
    
    func shuffle() {
        // Fisher-Yates shuffle from SO
        // http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
        for i in 0..<(planes.count - 1) {
            let j = Int(arc4random_uniform(UInt32(planes.count - i))) + i
            swap(&planes[i], &planes[j])
        }
    }
}
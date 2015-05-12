//
//  DeckViewDelegate.swift
//  Planechase
//
//  Created by Aaron Baker on 5/11/15.
//  Copyright (c) 2015 Aaron Baker. All rights reserved.
//

protocol DeckViewDelegate {
    var planesDeck: PlanesDeck! { get set }
    
    func doShuffle()
    func doReset()
}

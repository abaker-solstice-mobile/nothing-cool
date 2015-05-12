//
//  PlanesScrollViewController.swift
//  Planechase
//
//  Created by Aaron Baker on 5/10/15.
//  Copyright (c) 2015 Aaron Baker. All rights reserved.
//

import UIKit

class PlanesScrollViewController : UICollectionViewController, DeckViewDelegate {
    var pageDisplayDelegate: PageDisplayDelegate!
    var planesDeck: PlanesDeck!
    
    var frameWidth: CGFloat {
        return view.frame.width
    }
    
    var frameHeight: CGFloat {
        return view.frame.height
    }
    
    private var images: [String:UIImage] = [:]
    
    override func viewDidLoad() {
        for plane in planesDeck.planes {
            loadImage(plane.imageName)
        }

        collectionView!.contentSize = CGSize(width: frameWidth * CGFloat(planesDeck.cardCount), height: frameHeight)
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        (collectionView!.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: frameWidth, height: frameHeight)
    }
    
    func loadImage(name: String) -> UIImage {
        if images[name] == nil {
            images[name] = UIImage(named: name)!
        }
        return images[name]!
    }
    
    func getPlaneImageView(forPlaneAtIndex index: Int) -> UIImageView {
        var planeImage = loadImage(planesDeck.planes[index].imageName)
        
        // Match the frame height
        var height = frameHeight
        // Scale the width proportionally
        var width = (frameHeight / planeImage.size.height) * planeImage.size.width
        // Center the image horizontally
        var x = (frameWidth - width) / 2
        
        // Create the imageView, set the image, and return
        var imageView = UIImageView(frame: CGRect(x: x, y: 0, width: width, height: height))
        imageView.image = planeImage
        return imageView
    }
    
    // MARK: - Implement DeckViewDelegate
    func doShuffle() {
        planesDeck.shuffle()
        doReset()
    }
    
    func doReset() {
        collectionView?.scrollToItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
        collectionView?.reloadData()
    }
    
    // MARK: - Implement UICollectionViewController
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1 // Will only have one set of planes
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planesDeck.cardCount // Will map the planesDict items to the collection view
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.frame = CGRect(x: frameWidth * CGFloat(indexPath.row), y: 0, width: frameWidth, height: frameHeight)
        cell.addSubview(getPlaneImageView(forPlaneAtIndex: indexPath.row))
        
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = collectionView!.contentOffset.x + frameWidth / 2
        var page = floor(offset / frameWidth)
        pageDisplayDelegate.didPageChange(Int(page))
    }
}

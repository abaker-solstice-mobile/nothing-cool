//
//  PlaneChaseViewController
//  Planechase
//
//  Created by Aaron Baker on 5/11/15.
//  Copyright (c) 2015 Aaron Baker. All rights reserved.
//

import UIKit

class PlaneChaseViewController : UIViewController, PageDisplayDelegate {
    var planesDeck = PlanesDeck()
    
    @IBOutlet weak var pageDisplayLabel: UILabel!
    
    @IBAction func goToFirst(sender: UIButton) {
        deckViewDelegate?.doReset()
    }
    
    @IBAction func shuffleDeck(sender: UIButton) {
        deckViewDelegate?.doShuffle()
    }
    
    private var deckViewDelegate: DeckViewDelegate?
    
    override func viewDidLoad() {
        didPageChange(0)
    }
    
    // MARK: - Implement PageDisplayDelegate
    func didPageChange(index: Int) {
        pageDisplayLabel.text = "\((index + 1)) / \(planesDeck.cardCount)"
    }
    
    // MARK: - Segue handling
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch(identifier) {
            case "EmbedPlanesScrollView":
                let destinationController = segue.destinationViewController as! PlanesScrollViewController
                destinationController.pageDisplayDelegate = self
                deckViewDelegate = destinationController
                deckViewDelegate?.planesDeck = planesDeck
                break
            default:
                //We're making a segue that we don't need further information for
                break
            }
        }
    }
}

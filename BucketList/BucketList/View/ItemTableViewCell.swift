//
//  ItemTableViewCell.swift
//  BucketList
//
//  Created by Owen Henley on 7/19/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

//step 1-
protocol ItemTableViewCellDelegate: class { // create a protocol, you have to do this if youre a delegate
    func toggleItemComplete(cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    
    var item: Item? { // when it gets set, something happens, soi we need to
        didSet {
            updateViews()
        }
    }
// step 2 -
    weak var delegate: ItemTableViewCellDelegate?
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCompleteLebel: UIButton!

    func updateViews() {
        guard let item = item else { return }
        itemNameLabel.text = item.name
        
        // if the item is equal to true ....
        item.isComplete ? itemCompleteLebel.setBackgroundImage(UIImage(named: "complete"), for: .normal) : itemCompleteLebel.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
    }
    
    @IBAction func itemCompleteTapped(_ sender: UIButton) {
        //step 3 - call the protocol functons to conform - hey someone cliked on te button, go do your stuff!
        delegate?.toggleItemComplete(cell: self) //the cell to change its itself
    }
}

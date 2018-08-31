//
//  ItemTableViewCell.swift
//  Shopping List
//
//  Created by Owen Henley on 7/20/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit
import CoreData

protocol ItemTableViewCellDelegate: class {
    func toggleItemComplete(cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shoppingItemName: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    var item: Item? {
        didSet {
            updateViews()
        }
    }

    weak var delegate: ItemTableViewCellDelegate?
    
    @IBAction func isCompleteTapped(_ sender: UIButton) {
        delegate?.toggleItemComplete(cell: self)
    }
    
    
    func updateViews() {
        guard let item = item else { return }
        shoppingItemName.text = item.name
        
        item.isComplete ? isCompleteButton.setBackgroundImage(UIImage(named: "completed"), for: .normal) : isCompleteButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
    }
}

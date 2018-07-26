//
//  iTunesItemTableViewCell.swift
//  AppleSearch2
//
//  Created by Owen Henley on 7/26/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class iTunesItemTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var iTunesItem: iTunesItem?
    
    var iTunesItemAlbumImage: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    func updateViews() {
        guard let iTunesItem = iTunesItem else { return }
        
        DispatchQueue.main.async {
            self.albumImageView.image = self.iTunesItemAlbumImage
            self.artistNameLabel.text = iTunesItem.artistName
            self.albumNameLabel.text = iTunesItem.albumName
            self.trackNameLabel.text = iTunesItem.trackName
        }
    }
}

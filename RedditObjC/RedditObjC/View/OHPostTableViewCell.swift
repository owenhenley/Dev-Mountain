//
//  OHPostTableViewCell.swift
//  RedditObjC
//
//  Created by Owen Henley on 8/1/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class OHPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    // MARK: - properties
    var post: OHPost? {
        didSet {
            updateViews()
        }
    }
    
    var thumbnail: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.updateImage()
            }
        }
    }

    func updateViews() {
        guard let post = post else { return }
        
        titleLabel.text = post.title
        upvotesLabel.text = "\(post.ups)"
        commentCountLabel.text = "\(post.commentCount)"
    }
    
    func updateImage() {
        guard let thumbnail = thumbnail else { return }
        postImageView.image = thumbnail
    }
    
    override func prepareForReuse() {
        postImageView.image = nil
    }
}

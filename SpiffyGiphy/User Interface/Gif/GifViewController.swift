//
//  GifViewController.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 2/26/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class GifViewController: UIViewController {
    fileprivate let item: MediaItem
    fileprivate let gif: GifImage
    
    init(item: MediaItem, gif: GifImage) {
        self.item = item
        self.gif = gif
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = gifView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        
        if let url = gif.url, let cacheKey = url as? NSString, let data = GifCache.shared.object(forKey: cacheKey) as? Data {
            gifView.gifImageView.animate(withGIFData: data)
        }
        
        gifView.titleLabel.text = item.title
        gifView.usernameLabel.text = item.username

        if let user = item.user, let profileUrl = user.profileUrl, let url = URL(string: profileUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            self.gifView.userProfileImageView.setImage(image)
                        }
                        
                        if let cacheKey = profileUrl as? NSString, let cacheValue = data as? NSData {
                            GifCache.shared.setObject(cacheValue, forKey: cacheKey)
                        }
                    }
                }
            }
        } else if let username = item.username {
            gifView.userProfileImageView.setPlaceholderText(username)
        }
    }

    lazy private(set) var gifView: GifView = {
        return GifView(
            frame: UIScreen.main.bounds,
            gif: gif
        )
    }()
}

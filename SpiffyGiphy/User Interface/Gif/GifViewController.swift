//
//  GifViewController.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 2/26/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class GifViewController: UIViewController {
    fileprivate let gif: GifImage
    
    init(gif: GifImage) {
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
        
        if let url = gif.url, let cacheKey = url as? NSString, let data = GifCache.shared.object(forKey: cacheKey) as? Data {
            gifView.gifImageView.animate(withGIFData: data)
        }
    }

    lazy private(set) var gifView: GifView = {
        return GifView(
            frame: UIScreen.main.bounds,
            gif: gif
        )
    }()
}

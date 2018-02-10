//
//  TrendingCollectionViewController.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/10/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TrendingCollectionViewController: UIViewController, UINavigationControllerDelegate {
    fileprivate let client: GiphyApiClient
    fileprivate var observationContext = 0
    fileprivate let layout: UICollectionViewFlowLayout

    init(collectionViewLayout layout: UICollectionViewFlowLayout, client: GiphyApiClient) {
        self.layout = layout
        self.client = client
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = trendingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        trendingView.collectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        client.getTrending { (result) in
            switch result {
            case .Success(let list):
                self.trendingView.dataSource.gifs.append(contentsOf: list.data)
                self.trendingView.collectionView.reloadData()
            case .Error(_), .NotFound, .ServerError(_), .ClientError(_), .UnexpectedResponse(_):
                print("Error!")
            }
        }
    }
    lazy private(set) var trendingView: TrendingView = {
        return TrendingView(
            frame: UIScreen.main.bounds,
            collectionViewLayout: layout,
            dataSource: TrendingCollectionViewDataSource()
        )
    }()
}

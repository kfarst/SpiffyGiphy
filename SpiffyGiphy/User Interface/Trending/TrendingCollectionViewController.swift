//
//  TrendingCollectionViewController.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/10/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TrendingCollectionViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    fileprivate let client: GiphyApiClient
    fileprivate var observationContext = 0
    fileprivate let layout: UICollectionViewFlowLayout
    weak var coordinator: TrendingSearchFlowCoordinator?
    fileprivate var tapRecognizer: UITapGestureRecognizer?

    init(collectionViewLayout layout: UICollectionViewFlowLayout, client: GiphyApiClient) {
        self.layout = layout
        self.client = client
            
        super.init(nibName: nil, bundle: nil)
        
        tapRecognizer =  {
            let g = UITapGestureRecognizer(target: self, action: #selector(TrendingCollectionViewController.blurSearchView(_:)))
            g.delegate = self
            return g
        }()
        
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
        trendingView.searchFocusView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(TrendingCollectionViewController.toggleKeyboard(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TrendingCollectionViewController.toggleKeyboard(_:)), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
        
    @objc fileprivate func toggleKeyboard(_ notification: NSNotification) {
        if let tapRecognizer = tapRecognizer {
            switch notification.name  {
            case .UIKeyboardWillShow:
                trendingView.searchFocusView.addGestureRecognizer(tapRecognizer)
                trendingView.searchFocusView.isHidden = false
            default:
                trendingView.searchFocusView.removeGestureRecognizer(tapRecognizer)
                trendingView.searchFocusView.isHidden = true
            }
        }
    }
    
    @objc fileprivate func blurSearchView(_ sender: UITapGestureRecognizer) {
        trendingView.searchBar.resignFirstResponder()
    }
    
    lazy private(set) var trendingView: TrendingView = {
        return TrendingView(
            frame: UIScreen.main.bounds,
            collectionViewLayout: layout,
            dataSource: TrendingCollectionViewDataSource(with: coordinator!)
        )
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

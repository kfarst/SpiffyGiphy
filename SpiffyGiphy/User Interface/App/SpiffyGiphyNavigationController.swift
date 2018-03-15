//
//  SpiffyGiphyNavigationController.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/10/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class SpiffyGiphyNavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
    weak var coordinator: Coordinator?
    fileprivate let navDelegate = NavDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = navDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(delegate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

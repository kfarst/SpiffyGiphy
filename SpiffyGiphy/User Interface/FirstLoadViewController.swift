//
//  FirstLoadViewController.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/11/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

protocol FirstLoadViewControllerDelegate: class {
    func showTrendingView()
}
class FirstLoadViewController: UIViewController {
    weak var delegate: FirstLoadViewControllerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        delegate?.showTrendingView()
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

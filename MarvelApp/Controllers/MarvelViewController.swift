//
//  MarvelViewController.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//

import UIKit
import Reachability

class MarvelViewController: UIViewController {

    lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
                                               
    override func viewDidLoad() {
        super.viewDidLoad()

        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        
        activityIndicator.color = .red
        activityIndicator.startAnimating()
        activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: 44, height: CGFloat(44))

    }

}

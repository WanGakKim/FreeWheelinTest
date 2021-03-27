//
//  ViewController.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/27.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//
	

import UIKit

class ViewController: UIViewController {

    // MARK: initializing
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    
    //MARK: View Life Cycles + Set up Constraints
    
    private(set) var isSetConstraints = false
    
    override func viewDidLoad() {
        self.view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        if self.isSetConstraints == false {
            setConstraints()
            isSetConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func setConstraints(){
        
    }
    
}


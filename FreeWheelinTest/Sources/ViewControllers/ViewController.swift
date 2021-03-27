//
//  ViewController.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/27.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//


import UIKit

import RxSwift
import RxCocoa

import ReactorKit

class ViewController: UIViewController, View {
    
    typealias Reactor = ViewReactor
    
    //MARK: Constants
    
    struct Metric {
        static let barButtonSize = 41.f
        static let barButtonRadius = 11.f
    }
    
    struct Color {
        static let lineColor = UIColor.black
        static let barButtonBackgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    }
    
    struct Font {
        static let barButtonFont = UIFont.systemFont(ofSize: 11)
    }
    
    
    
    //MARK: Rx
    
    var disposeBag = DisposeBag()
    
    
    // MARK: initializing
    
    init(reactor: ViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.leftBarButtonItems =  [saveButtonItem,loadButtonItem]
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    //MARK: Binding
    
    func bind(reactor: ViewReactor) {
        <#code#>
    }
    
}


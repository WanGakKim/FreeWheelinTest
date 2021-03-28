//
//  ViewController.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/27.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//


import UIKit
import Vision

import RxSwift
import RxCocoa
import ReactorKit
import RxGesture
class ViewController: UIViewController, ReactorKit.View {
    typealias Reactor = ViewReactor
    
    //MARK: Constants
    
    struct Metric {
        static let barButtonSize = 41.f
        static let barButtonRadius = 11.f
    }
    
    struct Color {
        static let lineColor = UIColor.black
        static let backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    }
    
    struct Font {
        static let barButtonFont = UIFont.systemFont(ofSize: 11)
    }
    
    
    //MARK: UI
    
    fileprivate let saveButtonItem = UIBarButtonItem().then {
        let button = UIButton()
        button.frame.size = .init(
            width: Metric.barButtonSize,
            height: Metric.barButtonSize)
        button.setBackgroundColor(
            Color.backgroundColor,
            for: .normal)
        button.layer.cornerRadius = Metric.barButtonRadius
        button.clipsToBounds = true
        button.titleLabel?.font = Font.barButtonFont
        button.setTitle("SAVE", for: .normal)
        $0.customView = button
    }
    fileprivate let loadButtonItem = UIBarButtonItem().then {
        let button = UIButton()
        button.frame.size = .init(
            width: Metric.barButtonSize,
            height: Metric.barButtonSize)
        button.setBackgroundColor(
            Color.backgroundColor,
            for: .normal)
        button.layer.cornerRadius = Metric.barButtonRadius
        button.clipsToBounds = true
        button.titleLabel?.font = Font.barButtonFont
        button.setTitle("LOAD", for: .normal)
        $0.customView = button
    }
    fileprivate let penButtonItem = UIBarButtonItem().then {
        let button = UIButton()
        button.frame.size = .init(
            width: Metric.barButtonSize,
            height: Metric.barButtonSize)
        button.setBackgroundColor(
            Color.backgroundColor,
            for: .normal)
        button.layer.cornerRadius = Metric.barButtonRadius
        button.clipsToBounds = true
        button.titleLabel?.font = Font.barButtonFont
        button.setTitle("PEN", for: .normal)
        $0.customView = button
    }
    fileprivate let eraseButtonItem = UIBarButtonItem().then {
        let button = UIButton()
        button.frame.size = .init(
            width: Metric.barButtonSize,
            height: Metric.barButtonSize)
        button.setBackgroundColor(
            Color.backgroundColor,
            for: .normal)
        button.layer.cornerRadius = Metric.barButtonRadius
        button.clipsToBounds = true
        button.titleLabel?.font = Font.barButtonFont
        button.setTitle("ERASE", for: .normal)
        $0.customView = button
        
    }
    fileprivate let drawImageView = UIImageView().then {
        $0.backgroundColor = Color.backgroundColor
        
    }
    
    //MARK: Rx
    
    var disposeBag = DisposeBag()
    
    
    // MARK: initializing
    
    init(reactor: ViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.leftBarButtonItems = [ saveButtonItem, loadButtonItem ]
        self.navigationItem.rightBarButtonItems = [ eraseButtonItem, penButtonItem ]
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycles + Set up Constraints
    
    private(set) var isSetConstraints = false
    
    override func viewDidLoad() {
        self.view.setNeedsUpdateConstraints()
        super.viewDidLoad()
        
        view.addSubview(drawImageView)
    }
    
    override func updateViewConstraints() {
        print("update")
        if self.isSetConstraints == false {
            setConstraints()
            isSetConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func setConstraints(){
        drawImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: Binding
    
    func bind(reactor: ViewReactor) {
        print("binding")
        
        (saveButtonItem.customView as! UIButton).rx.tap
            .map{ Reactor.Action.save }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        (loadButtonItem.customView as! UIButton).rx.tap
            .map{ Reactor.Action.load(self.drawImageView) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        (penButtonItem.customView as! UIButton).rx.tap
            .map{ Reactor.Action.pen }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        (eraseButtonItem.customView as! UIButton).rx.tap
            .map{ Reactor.Action.erase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        drawImageView.rx
            .panGesture()
            .share(replay: 1)
            .asObservable()
            .map { Reactor.Action.draw(self.drawImageView,$0)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
}

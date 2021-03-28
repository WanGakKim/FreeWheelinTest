//
//  PaintService.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/28.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//
	

import RxSwift
import RxCocoa

enum PaintEvent {
    case save
    case load

//    case back
//    case foward
}

protocol PaintServiceType {
    var event: PublishRelay<PaintEvent> { get }
    // 로드
    func fetchPaint() -> Observable<Paint>
    // 세이브
    func savePaint(paint: Paint) -> Observable<Void>
}

final class PaintService: BaseService, PaintServiceType {
    var event = PublishRelay<PaintEvent>()
    
    /// Paint를 가져옵니다.
    ///
    /// 기존에 UserDefault에 저장되어있는 값을 우선적으로 반환합니다.
    /// - Returns: Paint
    func fetchPaint() -> Observable<Paint> {
        defer {
            print("fetch Done")
        }
        // UserDefaults 에 값이 있을경우
        if let savedData = UserDefaults.standard.value(forKey: "paint") as? Data {
            guard let paint = try? JSONDecoder().decode(
                    Paint.self,
                    from: savedData
            ) else {
                print("Empty Paint")
                return .just(Paint())}
            print("Saved Paint")
            return .just(paint)
        }
        
        // Default 값
        let defaultPaint = Paint(imageData: Data())
        let data = try? JSONEncoder().encode(defaultPaint)
        UserDefaults.standard.set(data, forKey: "paint")
        print("Default Paint")
        return .just(defaultPaint)
    }
    
    /// Paint를 저장합니다.
    /// - Parameter paint: 저장되는 Paint Object
    /// - Returns: result를 가질 필요가 없어 Void 로 반환합니다.
    @discardableResult
    func savePaint(paint: Paint) -> Observable<Void> {
        defer { UserDefaults.standard.synchronize() }
        let data = try? JSONEncoder().encode(paint)
        UserDefaults.standard.set(data, forKey: "paint")
        print("saveDone")
        return .empty()
    }
}

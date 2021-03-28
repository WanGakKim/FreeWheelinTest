//
//  ViewReactor.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/27.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//


import ReactorKit
import RxGesture
import UIKit

enum PaintingToolType{
    case pen
    case eraser
}

final class ViewReactor: Reactor {
    
    enum Action {
        case draw(UIView, UIPanGestureRecognizer)
        case save
        case load(UIImageView)
        case pen
        case erase
    }
    
    enum Mutation {
        case drawLine(UIView, UIPanGestureRecognizer)
        case saveData
        case loadData(UIImageView, Paint)
        case choosePen
        case chooseErase
    }
    
    struct State {
        var startPoint = CGPoint.zero
        var toolType: PaintingToolType
        var lineWidth: CGFloat = 5.f
        var strokeColor: CGColor
        var image: UIImage?
    }
    
    // MARK: initializing
    let provider: ServiceProviderType
    var initialState: State
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        self.initialState = State(toolType: .pen, lineWidth: 5.f, strokeColor: UIColor.black.cgColor)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .save:
            return self.provider.paintService
                .savePaint(
                    paint: Paint(
                        imageData: currentState.image?.pngData())
                )
                .map {
                    return .saveData
            }
        case .load(let view):
            return self.provider.paintService.fetchPaint()
                .map { paint in
                    return .loadData(view, paint)
            }
        case .pen:
            return .just(.choosePen)
        case .erase:
            return .just(.chooseErase)
        case .draw(let view,let recognizer):
            return .just(.drawLine(view, recognizer))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .saveData:
            return newState
        case .loadData(let view,let paint):
            newState.image = UIImage.init(data: paint.imageData ?? Data())
            view.image = currentState.image
            
            print("load Done")
            return newState
        case .choosePen:
            newState.toolType = .pen
            newState.strokeColor = UIColor.black.cgColor
            newState.lineWidth = 5.f
            return newState
        case .chooseErase:
            newState.toolType = .eraser
            newState.strokeColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
            newState.lineWidth = 30.f
            return newState
            
        case .drawLine(let view, let recognizer):
            let location = recognizer.location(in: view)
            switch recognizer.state {
            case .began:
                newState.startPoint = location
                return newState
            case .changed:
                newState.image = self.drawLine(view as! UIImageView, fromPoint: state.startPoint, toPoint: location)
                newState.startPoint = location
                return newState
            default:
                return newState
            }
        }
    }
    
    private func drawLine(_ imageView: UIImageView, fromPoint: CGPoint, toPoint: CGPoint) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContext(imageView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        imageView.image?.draw(in: CGRect.init(origin: CGPoint.zero, size: imageView.frame.size))
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.round)
        context.setLineWidth(currentState.lineWidth)
        context.setStrokeColor(currentState.strokeColor)
        context.setBlendMode(.normal)
        context.strokePath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        imageView.image = image
        imageView.alpha = 1.0
        
        return image
    }
}

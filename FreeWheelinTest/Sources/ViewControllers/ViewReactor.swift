//
//  ViewReactor.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/27.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//


import ReactorKit
enum PaintingToolType{
    case pen
    case eraser
}

final class ViewReactor: Reactor {
    
    enum Action {
        case save
        case load
        case pen
        case erase
    }
    
    enum Mutation {
        case saveData
        case loadData
        case choosePen
        case chooseErase
    }
    
    struct State {
        var toolType: PaintingToolType
    }
    
    // MARK: initializing
    
    var initialState: State
    
    init() {
        self.initialState = State(toolType: .pen)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .save:
            return .just(.saveData)
        case .load:
            return .just(.loadData)
        case .pen:
            return .just(.choosePen)
        case .erase:
            return .just(.chooseErase)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .saveData:
            return newState
        case .loadData:
            return newState
        case .choosePen:
            newState.toolType = .pen
            return newState
        case .chooseErase:
            newState.toolType = .eraser
            return newState
            
        }
    }
    
}

//
//  ViewReactor.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/27.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//
	

import ReactorKit

final class ViewReactor: Reactor {
    
    
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        init() {
            
        }
    }
    
    // MARK: initializing
    
    var initialState: State = State()
    
    init(state:State) {
        self.initialState = state
    }
}

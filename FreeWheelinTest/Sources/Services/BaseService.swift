//
//  BaseService.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/28.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//
	
class BaseService {
    unowned let provider: ServiceProviderType
    
    init(provider: ServiceProvider) {
        self.provider = provider
    }
}

//
//  ServiceProvider.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/28.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//

protocol ServiceProviderType: class {
    var paintService: PaintServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var paintService: PaintServiceType = PaintService(provider: self)
}

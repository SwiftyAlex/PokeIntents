//
//  DataSource.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import Combine

protocol DataSource {
    var pokemon: CurrentValueSubject<[Pokemon], Never> { get }
    func reload()
}

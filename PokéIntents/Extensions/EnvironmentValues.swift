//
//  EnvironmentValues.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI
import Combine

@available(iOS 13.0, *)
struct DataSourceKey: EnvironmentKey {
    static let defaultValue: DataSource = PlaceholderDataSource()
    private struct PlaceholderDataSource: DataSource {
        var pokemon: CurrentValueSubject<[Pokemon], Never> = .init([])
        func reload() { }
    }
}

@available(iOS 13.0, *)
extension EnvironmentValues {
    var dataSource: DataSource {
        get { self[DataSourceKey.self] }
        set { self[DataSourceKey.self] = newValue }
    }
}

@available(iOS 13.0, *)
struct FavouriteStoreKey: EnvironmentKey {
    static let defaultValue: FavouritesStore = FavouritesStore()
}

@available(iOS 13.0, *)
extension EnvironmentValues {
    var favouritesStore: FavouritesStore {
        get { self[FavouriteStoreKey.self] }
        set { self[FavouriteStoreKey.self] = newValue }
    }
}


@available(iOS 13.0, *)
struct IntentsBridgeKey: EnvironmentKey {
    static let defaultValue: IntentBridge = IntentBridge.shared
}

@available(iOS 13.0, *)
extension EnvironmentValues {
    var intentsBridge: IntentBridge {
        get { self[IntentsBridgeKey.self] }
        set { self[IntentsBridgeKey.self] = newValue }
    }
}

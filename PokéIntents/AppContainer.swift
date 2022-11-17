//
//  AppContainer.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation

/// Simple way of managing dependencies at the root level
/// For testability, make it so that the root level views pull from a different container
class AppContainer {
    // MARK: - Data
    static let dataSource = LocalDataSource(favouritesStore: favouritesStore)
    static let favouritesStore = FavouritesStore()

    // MARK: - Intents
    static let intentBridge = IntentBridge.shared
}

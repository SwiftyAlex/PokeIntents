//
//  Poke_IntentsApp.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI

@main
struct Poke_IntentsApp: App {
    let dataSource: DataSource = AppContainer.dataSource
    @ObservedObject var favouritesStore: FavouritesStore = AppContainer.favouritesStore
    @ObservedObject var intentBridge: IntentBridge = AppContainer.intentBridge

    var body: some Scene {
        WindowGroup {
            ContentView(model: ContentModel(intentBridge: intentBridge))
                .environment(\.dataSource, dataSource)
                .environment(\.favouritesStore, favouritesStore)
                .onChange(of: favouritesStore.favourites) { favourites in
                    dataSource.reload()
                }
                .onAppear {
                    PokeIntentsShortcutsProvider.updateAppShortcutParameters()
                }
        }
    }
}

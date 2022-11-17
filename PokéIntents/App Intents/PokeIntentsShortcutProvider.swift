//
//  PokeIntentsShortcutProvider.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import AppIntents

final class PokeIntentsShortcutsProvider: AppShortcutsProvider {
    public static var shortcutTileColor: ShortcutTileColor = .red

    @AppShortcutsBuilder
    public static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: ViewFavouritesIntent(), phrases: [
            "\(.applicationName) show me my favourites."
        ])
        AppShortcut(intent: ViewPokemonIntent(), phrases: [
            "\(.applicationName) show me \(\.$pokemon)"
        ])
        AppShortcut(intent: OpenPokemonIntent(), phrases: [
            "\(.applicationName) open \(\.$pokemon)"
        ])
        AppShortcut(intent: FavouritePokemonIntent(), phrases: [
            "\(.applicationName) toggle \(\.$pokemon)"
        ])
    }
}

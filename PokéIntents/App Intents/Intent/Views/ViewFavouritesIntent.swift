//
//  ViewFavouritesIntent.swift
//  PokéIntents
//
//  Created by Alex Logan on 16/11/2022.
//

import Foundation
import AppIntents

struct ViewFavouritesIntent: AppIntent {
    static var title: LocalizedStringResource = "Open your favourites"
    static var description: IntentDescription = IntentDescription(
        "Open your favourites",
        categoryName: "Pokemon"
    )
    static var openAppWhenRun: Bool = true

    @MainActor
    func perform() async throws -> some IntentResult {
        IntentBridge.shared.openFavourites()
        return .result()
    }
}

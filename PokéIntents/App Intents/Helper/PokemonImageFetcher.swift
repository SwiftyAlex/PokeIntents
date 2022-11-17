//
//  PokemonImageFetcher.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import UIKit.UIImage

enum PokemonImageFetcher {
    static func fetchImage(pokemon: Pokemon) async -> UIImage? {
        guard let url = URL(string: pokemon.primarySprite?.url ?? "") else {
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}

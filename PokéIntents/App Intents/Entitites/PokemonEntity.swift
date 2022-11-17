//
//  PokemonEntity.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import AppIntents

// MARK: - Entity
public final class PokemonEntity: AppEntity {
    public let id: Int

    @EntityProperty(title: "Number")
    public var number: Int

    @EntityProperty(title: "Name")
    public var name: String

    @EntityProperty(title: "Favourite")
    public var favourite: Bool

    @EntityProperty(title: "Image")
    public var image: IntentFile?

    init(pokemon: Pokemon) {
        self.id = pokemon.id
        self.number = pokemon.id
        self.name = pokemon.name.capitalized(with: .autoupdatingCurrent) // If we don't do this siri gets confused
        self.favourite = pokemon.favourite
        self.image = nil
    }
}

extension PokemonEntity: TypeDisplayRepresentable {
    public static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Pokémon")
}

extension PokemonEntity {
    public typealias DefaultQuery = PokemonQuery
    public static var defaultQuery: PokemonQuery = PokemonQuery()

    public var displayRepresentation: DisplayRepresentation {
        var image: DisplayRepresentation.Image?

        // Some intents fetch the image and populate it in post, like here.
        if let intentImage = self.image {
            image = .init(data: intentImage.data)
        }

        return DisplayRepresentation(
            title: "\(name)",
            subtitle: "\(number)",
            image: image
        )
    }
}

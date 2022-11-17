//
//  Mapper.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import Foundation

struct PokemonMapper {
    let favouritesStore: FavouritesStore

    func map(pokemon: PokemonV2Pokemon) -> Pokemon {
        return Pokemon(
            id: pokemon.id,
            name: pokemon.name,
            sprites: mapSprites(sprites: pokemon.pokemonV2Pokemonsprites),
            moves: mapMoves(moves: pokemon.pokemonV2Pokemonmoves),
            favourite: favouritesStore.isFavourite(pokemonId: pokemon.id)
        )
    }

    func mapMoves(moves: [PokemonV2Pokemonmove]) -> [Pokemon.Move] {
        let mappedMoves = moves.map { moveContainer in
            Pokemon.Move(name: moveContainer.pokemonV2Move.name)
        }
        return Array(Set(mappedMoves))
    }

    // This map is a litle awkward
    // The JSON is stored as an escaped string in the other JSON, so we have to make a dictionary out of it to get something usable
    // This does not support all the sprites available and for now just stores the name and url of the root level sprites.
    func mapSprites(
        sprites: [PokemonV2Pokemonsprite]
    ) -> [Pokemon.Sprite] {
        sprites.compactMap { spritesContainer -> [Pokemon.Sprite]? in
            guard let data = spritesContainer.sprites.data(using: .utf8),
                  let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return nil
            }
            return jsonDictionary.compactMap { (key, value) in
                guard let value = value as? String else { return nil }
                return Pokemon.Sprite(name: key, url: value)
            }.sorted(by: { $0.name > $1.name })
        }.flatMap({ $0 })
    }
}

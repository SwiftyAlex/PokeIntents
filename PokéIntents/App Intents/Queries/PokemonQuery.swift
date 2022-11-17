//
//  PokemonQuery.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import AppIntents

@available(iOS 16, *)
public struct PokemonQuery: EntityPropertyQuery {
    public init() { }

    public func entities(for identifiers: [Int]) async throws -> [PokemonEntity] {
        let datasource = LocalDataSource()
        return datasource.pokemon.value.filter { pokemon in
            identifiers.contains(pokemon.id)
        }.map(PokemonEntity.init(pokemon:))
    }

    public static var properties = EntityQueryProperties<PokemonEntity, PokemonComparator> {
        Property(\PokemonEntity.$name) {
            EqualToComparator { .nameEquals(name: $0) }
            ContainsComparator { .nameContains(name: $0) }
        }
        Property(\PokemonEntity.$number) {
            LessThanComparator { .numberBelow(number: $0) }
            GreaterThanComparator { .numberAbove(number: $0) }
            EqualToComparator { .numberEquals(number: $0) }
        }
    }

    public static var sortingOptions = SortingOptions {
        SortableBy(\PokemonEntity.$name)
        SortableBy(\PokemonEntity.$number)
    }

    public func entities(
        matching comparators: [PokemonComparator],
        mode: ComparatorMode,
        sortedBy: [EntityQuerySort<PokemonEntity>],
        limit: Int?
    ) async throws -> [PokemonEntity] {

        let datasource = LocalDataSource()
        let allPokemon = datasource.pokemon.value
        var pokemon: [Pokemon] = mode == .and ? allPokemon : []

        for comparator in comparators {
            let filterPokemon = mode == .and ? pokemon : allPokemon
            let filterResults = filterPokemon.filter { pokemon in
                switch comparator {
                case .nameEquals(let name):
                    return pokemon.name.lowercased() == name.lowercased()
                case .nameContains(let name):
                    return pokemon.name.lowercased().contains(name.lowercased())
                case .numberBelow(let number):
                    return pokemon.id < number
                case .numberAbove(let number):
                    return pokemon.id > number
                case .numberEquals(let number):
                    return pokemon.id == number
                }
            }
            switch mode {
            case .and:
                pokemon = filterResults
            case .or:
                pokemon = Array(Set(filterResults + pokemon))
            }
        }

        var entitites = pokemon.map(PokemonEntity.init(pokemon:))

        // Only handle one of these for convenience
        // Sort firt so they get the first ten that match, not a random set
        if let sort = sortedBy.first {
            entitites = entitites.sorted(by: {
                sortPokemonPair(pokemon: ($0, $1), sort: sort)
            })
        }

        if let limit = limit {
            entitites = Array(
                entitites.prefix(upTo: min(limit, entitites.count))
            )
        }

        return entitites
    }

    private func sortPokemonPair(
        pokemon: (PokemonEntity, PokemonEntity),
        sort: EntityQuerySort<PokemonEntity>
    ) -> Bool {
        let lhs = pokemon.0
        let rhs = pokemon.1
        if let lhsValue = lhs[keyPath: sort.by] as? EntityProperty<String>,
            let rhsValue = rhs[keyPath: sort.by] as? EntityProperty<String> {
            return sort.order == .ascending ? lhsValue.wrappedValue > rhsValue.wrappedValue : lhsValue.wrappedValue > rhsValue.wrappedValue
        } else if let lhsValue = lhs[keyPath: sort.by] as? EntityProperty<Int>, let rhsValue = rhs[keyPath: sort.by] as? EntityProperty<Int> {
            return sort.order == .ascending ? lhsValue.wrappedValue < rhsValue.wrappedValue : lhsValue.wrappedValue > rhsValue.wrappedValue
        } else {
            return true
        }
    }

    public func suggestedEntities() async throws -> [PokemonEntity] {
        let datasource = LocalDataSource()
        return datasource.pokemon.value.map { pokemon in
            PokemonEntity(pokemon: pokemon)
        }
    }
}

public enum PokemonComparator {
    case nameEquals(name: String)
    case nameContains(name: String)
    case numberBelow(number: Int)
    case numberAbove(number: Int)
    case numberEquals(number: Int)
}

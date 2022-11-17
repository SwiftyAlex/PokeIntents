//
//  PokemonRow.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon

    var body: some View {
        HStack(spacing: 12) {
            image
            textStack
        }
        .animation(.easeInOut, value: pokemon.favourite)
    }

    var textStack: some View {
        HStack {
            Text(pokemon.name)
                .font(.headline.weight(.semibold))
                .foregroundColor(.text)
            if pokemon.favourite {
                Image(systemName: "star.fill")
                    .font(.headline.weight(.bold))
                    .foregroundColor(Color.red)
                    .transition(.opacity)
            }
            Spacer()
            Text("\(pokemon.id)")
                .font(.headline.weight(.semibold))
                .foregroundColor(.textSecondary)
        }
    }

    var image: some View {
        AsyncImage(
            url: URL(string: pokemon.primarySprite?.url ?? ""),
            content: { image in
                image.resizable().modifier(ImageModifier())
            }, placeholder: {
                Color.secondary.opacity(0.2).modifier(ImageModifier())
            })
    }
}

private struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fill)
            .frame(width: 44, height: 44, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 5.5))
            .transition(.opacity.animation(.easeInOut))
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(
            pokemon: .manaphy
        )
    }
}

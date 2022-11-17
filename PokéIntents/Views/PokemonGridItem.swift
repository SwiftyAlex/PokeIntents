//
//  PokemonGridItem.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI

struct PokemonGridItem: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            image
            // This is currently not very accessible, and should be better
            Text(pokemon.name)
                .font(.subheadline.weight(.semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .foregroundColor(.text)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(.cbWhite)
        )
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
            .aspectRatio(1.0, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 5.5))
            .transition(.opacity.animation(.easeInOut))
    }
}

struct PokemonGridItem_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGridItem(pokemon: .manaphy)
    }
}

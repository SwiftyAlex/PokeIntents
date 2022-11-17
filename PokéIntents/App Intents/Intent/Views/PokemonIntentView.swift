//
//  PokemonIntentView.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import SwiftUI

struct PokemonIntentView: View {
    let pokemon: Pokemon?
    let image: UIImage?

    var body: some View {
        HStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
            }
            if let pokemon = pokemon {
                VStack(alignment: .leading) {
                    Text(pokemon.name)
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.primary)
                    Text("\(pokemon.id)")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.secondary)
                }
                Spacer()
                if pokemon.favourite {
                    Image(systemName: "star.fill")
                        .font(.headline.weight(.bold))
                        .foregroundColor(Color.red)
                        .transition(.opacity)
                }
            } else {
                Text("Couldn't find your pokémon.")
            }
        }
        .padding()
    }
}

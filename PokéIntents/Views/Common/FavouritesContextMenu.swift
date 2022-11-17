//
//  FavouritesContextMenu.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import SwiftUI

extension View {
    func favouritable(
        pokemon: Pokemon,
        favouritesStore: FavouritesStore
    ) -> some View {
        self
            .contextMenu(menuItems: {
                let isFavourite = favouritesStore.isFavourite(pokemon: pokemon)
                let imageName = isFavourite ? "star.slash.fill" : "star.fill"
                let text = isFavourite ? "Remove from favourites" : "Add to favourites"
                Button(action: {
                    // The view that creates this will actually be destroyed, so lets run this work after the menu goes away
                    DispatchQueue.main.asyncAfter(deadline: .now()+1/6) {
                        favouritesStore.toggle(pokemon: pokemon)
                    }
                }, label: {
                    Label(text, systemImage: imageName)
                })
            })
    }
}

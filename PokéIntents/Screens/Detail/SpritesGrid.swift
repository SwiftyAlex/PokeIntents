//
//  SpritesGrid.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import SwiftUI

struct SpritesGrid: View {
    let sprites: [Pokemon.Sprite]

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 100), spacing: 12)
        ], alignment: .center, spacing: 12, pinnedViews: [], content: {
            ForEach(sprites, id: \.name) { sprite in
                SpriteGridItem(sprite: sprite)
            }
        })
        .buttonStyle(BasicSquishyButtonStyle())
    }
}


struct SpritesGrid_Previews: PreviewProvider {
    static var previews: some View {
        SpritesGrid(sprites: [])
    }
}

//
//  MovesList.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import SwiftUI

struct MovesList: View {
    var moves: [Pokemon.Move]

    var body: some View {
        PokeContainer {
            List {
                Section {
                    ForEach(moves, id: \.name) {
                        Text($0.name)
                            .font(.body)
                            .foregroundColor(.text)
                            .listRowBackground(Color.cbWhite)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Moves")
        }
    }
}

struct MovesList_Previews: PreviewProvider {
    static var previews: some View {
        MovesList(moves: [])
    }
}

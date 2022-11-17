//
//  ButtonStyle.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import Foundation
import SwiftUI

struct BasicSquishyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

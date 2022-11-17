//
//  ContentModel.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import Combine
import SwiftUI

class ContentModel: ObservableObject {
    let intentBridge: IntentBridge

    @Published var destinations: Set<IntentDestination> = []
    private var cancellables: Set<AnyCancellable> = []

    init(intentBridge: IntentBridge = .shared) {
        self.intentBridge = intentBridge

        intentBridge.$destinations.receive(on: RunLoop.main).sink { destinations in
            self.destinations = destinations
        }
        .store(in: &cancellables)
    }

    func consume(destination: IntentDestination) {
        intentBridge.destinations.remove(destination)
    }

}

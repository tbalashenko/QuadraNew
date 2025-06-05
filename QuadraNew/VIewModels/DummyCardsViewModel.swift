//
//  DummyCardsViewModel.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 08/05/2024.
//

import Foundation
import Combine

enum SwipeAction {
    case left, right
}

class DummyCardsViewModel: ObservableObject {
    @Published var currentTime = Date()
    @Published var cardModels = [DummyCardModel]()
    @Published var swipeAction: SwipeAction?
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?

    private let service = DummyCardService()
    
    private var cancellables: Set<AnyCancellable> = []
    private var cancellable: AnyCancellable?

    init() {
        updateCardModels()
    }

    func removeCard(_ card: DummyCardModel) {
        guard let index = cardModels.firstIndex(where: { $0.id == card.id }) else { return }
        
        cardModels.remove(at: index)
        if cardModels.isEmpty {
            stopTimer()
        }
    }

    func timerAction() {
        swipeAction = cardModels.count % 2 == 0 ? SwipeAction.left : SwipeAction.right
    }

    func updateCardModels() {
        cardModels = service.fetchCardModels()
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
        cancellable = timer?
            .sink { [weak self] value in
                self?.timerAction()
            }
    }
    
    func stopTimer() {
        cancellable?.cancel()
        cancellable = nil
        timer = nil
        swipeAction = nil
    }
}

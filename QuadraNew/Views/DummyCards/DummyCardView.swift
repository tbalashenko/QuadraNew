//
//  DummyCardView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 08/05/2024.
//

import SwiftUI
import Combine

struct DummyCardView: View {
    @ObservedObject var viewModel: DummyCardsViewModel
    
    @State private var xOffset: CGFloat = .zero
    @State private var yOffset: CGFloat = .zero
    @State private var degrees: Double = 0
    
    let model: DummyCardModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .leading) {
                    model.item.image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.width * AspectRatio.sixteenToNine.ratio)
                        .clipped()
                    
                    HStack {
                        Image(systemName: "lightbulb.min.fill")
                            .resizable()
                            .foregroundStyle(Color.yellow)
                            .northWestShadow()
                            .shadow(
                                color: .yellow.opacity(0.2),
                                radius: 2
                            )
                            .frame(
                                width: geometry.size.width * 0.05,
                                height: geometry.size.width * 0.05
                            )
                        Text(model.item.title)
                            .font(.system(size: geometry.size.width * 0.08))
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .background(Color.element)
                .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
                .southEastShadow()
                .rotationEffect(.degrees(degrees))
                .offset(x: xOffset, y: yOffset)
                .animation(.snappy, value: xOffset)
                .gesture(
                    DragGesture()
                        .onChanged(onDragChanged)
                        .onEnded(onDragEnded)
                )
                .onReceive(viewModel.$swipeAction) { action in
                    onRecieveSwipeAction(action)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        IconCircleButton(systemName: "repeat", size: .xxs) { }
                    }
                }
                .offset(x: SizeConstants.dummyCardSize.width / -6, y: SizeConstants.dummyCardSize.height / -8)
            }
        }
    }
}

private extension DummyCardView {
    func returnToCenter() {
        xOffset = 0
        yOffset = 0
        degrees = 0
    }
    
    func swipeRight() {
        withAnimation(.snappy(duration: 1)) {
            xOffset = 500
            yOffset = 0
            degrees = 12
        } completion: {
            viewModel.removeCard(model)
        }
    }
    
    func swipeLeft() {
        withAnimation(.snappy(duration: 1)) {
            xOffset = -500
            yOffset = 0
            degrees = -12
        } completion: {
            viewModel.removeCard(model)
        }
    }
    
    func onRecieveSwipeAction(_ action: SwipeAction?) {
        guard let action = action else { return }
        
        let topCard = viewModel.cardModels.last
        
        if topCard == model {
            switch action {
                case .left:
                    swipeLeft()
                case .right:
                    swipeRight()
            }
        }
    }
}

private extension DummyCardView {
    func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        yOffset = value.translation.height
        degrees = Double(value.translation.width/25)
    }
    
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        if abs(width) <= SizeConstants.screenCutOff {
            returnToCenter()
            return
        }
        
        width >= SizeConstants.screenCutOff ? swipeRight() : swipeLeft()
    }
}

#Preview {
    DummyCardView(
        viewModel: DummyCardsViewModel(),
        model: DummyCardModel(item: MockData.mockedCards[0]))
    .frame(size: SizeConstants.dummyCardSize)
}

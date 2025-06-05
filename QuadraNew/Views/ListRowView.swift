//
//  ListRowView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 27/03/2024.
//

import SwiftUI
import SwiftData

struct ListRowView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var sizeConstants: SizeConstants
    @ObservedObject var cardViewModel: CardViewModel
    
    @State private var offset: CGFloat = -SizeConstants.screenWidth / 2
    @State private var lastOffset: CGFloat = .zero
    @State private var imageSize: CGSize = .zero
    @State private var isMaxImageSize: Bool = false

    var body: some View {
        ZStack {
            cardViewModel.card.croppedImage?
                .resizable()
                .scaledToFill()
                .frame(size: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
                .offset(x: offset)
                .if(isMaxImageSize) { $0.northWestShadow() }
                .gesture(dragGesture)
                .overlay(alignment: isMaxImageSize ? .leading : .trailing) {
                    overlayImage
                }
            
            if !isMaxImageSize {
                content
            }
        }
        .frame(height: imageSize.height)
        .if(!isMaxImageSize) { content in
            content.background {
                Color.element
                    .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
                    .northWestShadow()
            }
        }
        .background {
            NavigationLink(
                "",
                destination: CardView(viewModel: cardViewModel))
            .opacity(0)
                #warning("add this functionality back")
//                {
//                    withAnimation {
//                        cardViewModel.backToInput(context: ModelContext)
//                    }
//                }

            
        }
        .toolbarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            imageSize = sizeConstants.listImageSize
        }
    }

    
    private var overlayImage: some View {
        let color = cardViewModel.card.isImageDark ?? false ? Color.pureWhite : Color.pureBlack
        return Image(systemName: isMaxImageSize ? "arrow.left.to.line.compact" : "arrow.right.to.line.compact")
            .smallButtonImage()
            .foregroundColor(color)
            .offset(x: offset)
            .opacity(0.5)
            .padding(4)
    }
    
    private var content: some View {
        HStack {
            Spacer()
                .frame(width: cardViewModel.card.croppedImage != nil ? sizeConstants.listImageWidth / 2 - 16 : 0)
            Text(cardViewModel.card.convertedPhraseToRemember)
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
                .padding()
            Spacer()
        }
    }
}

extension ListRowView {
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                handleDragChanged(value: value)
            }
            .onEnded { value in
                handleDragEnded(value: value)
            }
    }
    
    private func handleDragChanged(value: DragGesture.Value) {
        if value.translation.width > 0, isMaxImageSize {
            self.offset = lastOffset
        }
    }
    
    private func handleDragEnded(value: DragGesture.Value) {
        if !isMaxImageSize, value.translation.width > 0 {
            withAnimation(.bouncy(duration: 2)) {
                offset = .zero
                imageSize = sizeConstants.listImageFullSize
                isMaxImageSize = true
            }
        } else if isMaxImageSize, value.translation.width < 0 {
            withAnimation(.bouncy(duration: 2)) {
                offset = -SizeConstants.screenWidth / 2
                imageSize = sizeConstants.listImageSize
                isMaxImageSize = false
            }
        }
        haptic(.medium)
        lastOffset = offset
    }
}

//
//  CardHeaderView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI

struct CardHeaderView: View {
    @EnvironmentObject var sizeConstants: SizeConstants
    @ObservedObject var viewModel: CardViewModel
    @State private var showFullImage: Bool = false
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(size: sizeConstants.imageSize)
                    .clipped()
            } else {
                Rectangle()
                    .foregroundColor(.element)
                    .frame(size: sizeConstants.imageSize)
                
            }
            AlignableView(alignment: .topTrailing) {
                TagView(
                    text: viewModel.status.title,
                    backgroundColor: viewModel.status.color
                )
            }
            AlignableTransparentButton(alignment: .topLeading) {
                Image(systemName: "info.circle.fill")
            } action: {
                viewModel.showAdditionalInfo.toggle()
            }
                
        }
        .frame(size: sizeConstants.imageSize)
        .onTapGesture {
            if let _ = viewModel.fullImage {
                showFullImage.toggle()
            }
        }
        .fullScreenCover(isPresented: $showFullImage) {
            if let image = viewModel.fullImage {
                FullImageView(image: image)
            }
        }
    }

}

#Preview {
    CardHeaderView(
        viewModel: CardViewModel(
            card: Card(
                phraseToRemember: "What is your name? What if it's longer than I expected",
                archiveTag: ArchiveTag(),
                cardSources: [],
                imageData: UIImage(named: "testImage")?.pngData(),
                croppedImageData: UIImage(named: "testImage")?.pngData()
            )
        )
    )
    .frame(size: SizeConstants(settings: SettingsService()).imageSize)
}

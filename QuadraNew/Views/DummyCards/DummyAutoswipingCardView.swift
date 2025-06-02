struct DummyAutoswipingCardView: View {
    @StateObject var viewModel = DummyCardsViewModel()
    
    var body: some View {
        ZStack {
            if !viewModel.cardModels.isEmpty {
                ArrowView()
            }
            DummyCardStackView(viewModel: viewModel)
        }
    }
}
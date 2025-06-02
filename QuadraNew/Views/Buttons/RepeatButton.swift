struct RepeatButton: View {
    var action: () -> Void
    
    var body: some View {
        PlainButtonWithImage(
            title: TextConstants.restart,
            image: "repeat.circle"
        ) {
            action()
        }
    }
}
                    Button(action: {
                        showSetupCardView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .smallButtonImage()
                            .foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(NeuButtonStyle())
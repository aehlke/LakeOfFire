import SwiftUI
import LakeKit

struct ReaderModeButtonBar: View {
    @ObservedObject var readerViewModel: ReaderViewModel
    
    var body: some View {
        ZStack {
            ReaderModeButton(readerViewModel: readerViewModel)
                .labelStyle(.titleOnly)
                .padding(.horizontal, 44)
                .buttonStyle(.borderedProminent)
                .controlSize(.regular)
                .padding(8)
            
            HStack {
                Spacer(minLength: 0)
                DismissButton {
                    Task { @MainActor in
                        try await readerViewModel.hideReaderModeButtonBar()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}

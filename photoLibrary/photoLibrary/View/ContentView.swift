//
//  ContentView.swift
//  photoLibrary
//
//  Created by electrozone on 3/31/26.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    @State private var loading: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                if let image = selectedImage {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(alignment: .bottom) {
                            if loading {
                                ProgressView().padding()
                            }
                        }
                } else {
                    VStack(spacing: 16) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 48))
                            .foregroundStyle(.secondary)
                        Text("Select an image")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    HStack {
                        Image(systemName: "photo")
                        Text("Select an image")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 12))
                }
                .onChange(of: selectedItem) { _, newItem in
                    Task { await loadImage(from: newItem) }
                }
            }
            .padding()
            .navigationTitle("Photo Library")
        }
    }

    private func loadImage(from item: PhotosPickerItem?) async {
        guard let item else { return }
        loading = true
        defer { loading = false }
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                await MainActor.run {
                    self.selectedImage = Image(uiImage: uiImage)
                }
            }
        } catch {
            // Handle errors silently for now
        }
    }
}

#Preview {
    ContentView()
}

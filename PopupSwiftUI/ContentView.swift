//
//  ContentView.swift
//  PopupSwiftUI
//
//  Created by Vadim Bulavin on 22.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoaderPresented = false
    @State private var isTopSnackbarPresented = false

    var body: some View {
        TabView {
            leftTab
            rightTab
        }
        .popup(isPresented: isTopSnackbarPresented, alignment: .top, direction: .top, content: Snackbar.init)
        .popup(isPresented: isLoaderPresented, alignment: .center, content: Loader.init)
    }

    private var leftTab: some View {
        VStack {
            Button(
                action: { self.isLoaderPresented.toggle() },
                label: { Text(isLoaderPresented ? "Hide Loader" : "Show Loader") }
            )
            Spacer()
        }
        .foregroundColor(.black)
        .tabItem { Label("Bottom", systemImage: "arrow.up") }
    }

    private var rightTab: some View {
        VStack {
            Button(
                action: { self.isTopSnackbarPresented.toggle() },
                label: { Text(isTopSnackbarPresented ? "Hide Alert" : "Show Alert") }
            )
        }
        .foregroundColor(.black)
        .tabItem { Label("Top", systemImage: "arrow.down") }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

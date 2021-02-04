//
//  ContentView.swift
//  PopupSwiftUI
//
//  Created by Vadim Bulavin on 22.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var isBottomSnackbarPresented = false
    @State private var isLoaderPresented = false
    @State private var isTopSnackbarPresented = false

    var body: some View {
        menu
            .popup(isPresented: $isBottomSnackbarPresented, alignment: .bottom, content: Snackbar.init)
            .popup(isPresented: $isTopSnackbarPresented, alignment: .top, direction: .top, content: Snackbar.init)
            .popup(isPresented: $isLoaderPresented, alignment: .center, content: Loader.init)
    }

    private var menu: some View {
        ZStack {
            Color.clear

            VStack(spacing: 10) {
                Button(
                    action: { self.isBottomSnackbarPresented.toggle() },
                    label: { Text(isBottomSnackbarPresented ? "Hide Bottom Snackbar" : "Show Bottom Snackbar") }
                )

                Button(
                    action: { self.isLoaderPresented.toggle() },
                    label: { Text(isLoaderPresented ? "Hide Loader" : "Show Loader") }
                )

                Button(
                    action: { self.isTopSnackbarPresented.toggle() },
                    label: { Text(isTopSnackbarPresented ? "Hide Top Snackbar" : "Show Top Snackbar") }
                )

                Spacer()
            }
            .foregroundColor(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


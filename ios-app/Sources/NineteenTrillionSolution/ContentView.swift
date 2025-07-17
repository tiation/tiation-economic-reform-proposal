//
//  ContentView.swift
//  19TrillionSolution
//
//  Created by Tia Astor on 07/16/25.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            WebView(url: URL(string: "https://tiation.github.io/19-trillion-solution/")!)
                .navigationBarTitle(Text("19 Trillion Solution"), displayMode: .inline)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


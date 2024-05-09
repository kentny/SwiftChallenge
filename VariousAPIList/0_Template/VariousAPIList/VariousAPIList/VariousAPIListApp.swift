//
//  VariousAPIListApp.swift
//  VariousAPIList
//
//  Created by Kentaro Terasaki on 2024/05/10.
//

import SwiftUI

enum AppPath {
    case album
    case photo
}

typealias AppNavigationPath = [AppPath]

@main
struct VariousAPIListApp: App {
    @State var path = AppNavigationPath()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                TopPageView(path: $path)
                    .navigationDestination(for: AppPath.self, destination: self.destination)
            }
        }
    }

    @ViewBuilder
    func destination(_ appPath: AppPath) -> some View {
        switch appPath {
        case .album:
            AlbumListPageView()
        case .photo:
            PhotoListPageView()
        }
    }
}

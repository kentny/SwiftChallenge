//
//  TopPageView.swift
//  VariousAPIList
//
//  Created by Kentaro Terasaki on 2024/05/08.
//

import SwiftUI

struct TopPageView: View {
    @Binding var path: AppNavigationPath

    var body: some View {
        VStack {
            Text("Choose a list")
            Button("Album List") {
                path.append(.album)
            }
            Button("Photo List") {
                path.append(.photo)
            }
        }
    }
}

#Preview {
    TopPageView(path: .constant(AppNavigationPath()))
}

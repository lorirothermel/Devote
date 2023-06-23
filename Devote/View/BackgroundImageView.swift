//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Lori Rothermel on 6/22/23.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }  // some View
}  // BackgroundImageView


struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}

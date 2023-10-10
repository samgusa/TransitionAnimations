//
//  View1.swift
//  CustomTransitionTest
//
//  Created by Sam Greenhill on 6/14/23.
//

import SwiftUI

struct View1: View {
    var namespace: Namespace.ID
    @Binding var show: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Spacer()
            VStack {
                Text("SwiftUI")
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
                Text("20 sections - 3 hours".uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtext", in: namespace)
                Text("Build an iOS app for iOS 15 with custom layouts, animations and ...")
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur", in: namespace)
            )
        }
        .foregroundColor(.white)
        .background {
            Image("Illustration 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "image", in: namespace)
        }
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)

        }
        .frame(height: 300)
        .padding(20)
    }
}

struct View1_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        View1(namespace: namespace, show: .constant(true))
    }
}

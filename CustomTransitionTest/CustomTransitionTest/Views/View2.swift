//
//  View2.swift
//  CustomTransitionTest
//
//  Created by Sam Greenhill on 6/14/23.
//

import SwiftUI

struct View2: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 500)
            .foregroundColor(.black)
            .background {
                Image("Illustration 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "image", in: namespace)
            }
            .background {
                Image("Background 5")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background", in: namespace)
            }
            .mask {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: namespace)

            }
            .overlay {
                VStack(alignment: .leading, spacing: 12) {
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
                    Divider()
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 26, height: 26)
                            .cornerRadius(10)
                            .padding(8)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous)
                            )
                        Text("Created by Me")
                            .font(.footnote)

                    }

                }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .matchedGeometryEffect(id: "blur", in: namespace)
                )
                .offset(y: 250)
                .padding(20)
            }
        }
    }
}

struct View2_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        View2(namespace: namespace, show: .constant(true))
    }
}

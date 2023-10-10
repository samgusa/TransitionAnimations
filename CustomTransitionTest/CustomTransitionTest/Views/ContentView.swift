//
//  ContentView.swift
//  CustomTransitionTest
//
//  Created by Sam Greenhill on 6/14/23.
//

import SwiftUI
/*
 Matched Geometry Effect should be used on individual elements, even including the color, anything that is styling should use that modifier.
 Dont use it on a VStack or after a frame,
 when there's a position change or a size change as what we did for the font.

 The individual elements should keep its integrity in term of styling, as long as it does not affect the size or the position so the integrity should be done before the modifier and the positioning should be done after.

 Next, when you reorder these elements, they're gonna work just fine

 when you're not applying the match geometry effect, its simply going to fall back to the default transition, which is going to be a fade in fade out on the element.
    -> Ex: if it's a background color, then it's simply show or hide the new view on top and then back and forth.
 */

struct ContentView: View {
    @Namespace var namespace
    @State var show = false

    var body: some View {
        ZStack {
            if !show {
                VStack(alignment: .leading, spacing: 12) {
                    Text("SwiftUI")
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("20 sections - 3 hours".uppercased())
                        .font(.footnote.weight(.semibold))
                    Text("Build an iOS app for iOS 15 with custom layouts, animations and ...")
                        .font(.footnote)
                        .matchedGeometryEffect(id: "text", in: namespace)
                }
                .padding(20)
                .foregroundColor(.white)
                .background {
                    Color.red
                        .matchedGeometryEffect(id: "background", in: namespace)
                }
                .padding(20)
            } else {
                VStack(alignment: .leading, spacing: 12) {
                    Spacer()
                    Text("Build an iOS app for iOS 15 with custom layouts, animations and ...")
                        .font(.footnote)
                        .matchedGeometryEffect(id: "text", in: namespace)
                    Text("20 sections - 3 hours".uppercased())
                        .font(.footnote.weight(.semibold))
                    Text("SwiftUI")
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
                .foregroundColor(.black)
                .background {
                    Color.blue
                        .matchedGeometryEffect(id: "background", in: namespace)
                }
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

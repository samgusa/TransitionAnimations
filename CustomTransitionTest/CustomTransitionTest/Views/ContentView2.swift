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

struct ContentView2: View {
    @Namespace var namespace
    @State var show = false

    var body: some View {
        ZStack {
            if !show {
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
            } else {
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
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }

@ViewBuilder
    func AvatarView() -> some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 26, height: 26)
                .cornerRadius(10)
                .padding(8)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous)
                )

        }
    }

}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

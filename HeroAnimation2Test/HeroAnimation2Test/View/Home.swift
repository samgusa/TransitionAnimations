//
//  Home.swift
//  HeroAnimation2Test
//
//  Created by Sam Greenhill on 6/13/23.
//

import SwiftUI
import Foundation

struct Home: View {
    // MARK: Animation Properties
    @State var currentItem: ColorValue?
    @State var expandCard: Bool = false
    // this variable below is helpful for moving the card down since when the card is touched, it moved a tiny bit downward before Hero Animation begins
    @State var moveCardDown: Bool = false
    @State var animateContent: Bool = false
    // Matched Geometry Namespace
    @Namespace var animation

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            // Extract safearea from proxy
            let safeArea = proxy.safeAreaInsets

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 8) {
                    ForEach(colors) { color in
                        CardView(item: color, rectSize: size)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
            }
            // Material Blur top Bar
            .safeAreaInset(edge: .top) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(height: safeArea.top)
                    .overlay {
                        Text("Color Picker")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .opacity(0.8)
                    }
                    .overlay(alignment: .trailing) {
                        Text("V1.0.9")
                            .font(.caption)
                            .foregroundColor(.black)
                            .padding(.trailing, 10)
                    }
            }
            // the views edges must first be ignored in order to fetch SafeArea
            .ignoresSafeArea(.container, edges: .all)
            .overlay {
                if let currentItem, expandCard {
                    DetailView(item: currentItem, rectSize: size)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(y: 10)))
                }
            }
        }
        .frame(width: 380, height: 500)
        .preferredColorScheme(.light)
    }

    @ViewBuilder
    func DetailView(item: ColorValue, rectSize: CGSize) -> some View {
        ColorView(item: item, rectSize: rectSize)
            .ignoresSafeArea()
            .overlay {
                ColorDetails(item: item, rectSize: rectSize)
            }
            .overlay(content: {
                DetailViewContent(item: item)
            })
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    animateContent = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        expandCard = false
                        moveCardDown = false
                    }
                }
            }
    }

    @ViewBuilder
    func DetailViewContent(item: ColorValue) -> some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .frame(height: 1)
                .scaleEffect(x: animateContent ? 1 : 0.001, anchor: .leading)
                .padding(.top, 60)

            // Custom Progress Bar showing RGB data
            VStack(spacing: 30) {
                CustomProgressView(value: 0.5, label: "Red")
                CustomProgressView(value: 0.5, label: "Blue")
                CustomProgressView(value: 0.5, label: "Green")
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
            }
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 0 : 100)
            // Slight dealy to finish the top scale animation.
            // dont need delay when closing
            .animation(.easeInOut(duration: 0.5).delay(animateContent ? 0.2: 0), value: animateContent)
            .padding(.top, 30)
            .padding(.horizontal, 20)

        }
        .padding(.horizontal, 15)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            withAnimation(.easeInOut.delay(0.2)) {
                animateContent = true
            }
        }
    }

    @ViewBuilder
    func CardView(item: ColorValue, rectSize: CGSize) -> some View {
        let tappedCard = item.id == currentItem?.id && moveCardDown

        if !(item.id == currentItem?.id && expandCard) {
            ColorView(item: item, rectSize: rectSize)
                .overlay(content: {
                    ColorDetails(item: item, rectSize: rectSize)
                })
                .frame(height: 110)
                .contentShape(Rectangle())
                .offset(y: tappedCard ? 30 : 0)
                .zIndex(tappedCard ? 100 : 0)
                .onTapGesture {
                    currentItem = item
                    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.4)) {
                        moveCardDown = true
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 1, blendDuration: 1)) {
                            expandCard = true
                        }
                    }
                }
        } else {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 110)
        }
    }

    // Reusable Color View
    @ViewBuilder
    func ColorView(item: ColorValue, rectSize: CGSize) -> some View {
        Rectangle()
            .overlay {
                Rectangle()
                    .fill(item.color.gradient)
            }
            .overlay {
                Rectangle()
                    .fill(item.color.opacity(0.5).gradient)
                    .rotationEffect(.init(degrees: 180))
            }
            .matchedGeometryEffect(id: item.id.uuidString, in: animation)
    }

    // Reusable Color Details
    @ViewBuilder
    func ColorDetails(item: ColorValue, rectSize: CGSize) -> some View {
        HStack {
            Text("#\(item.colorCode)")
                .font(.title.bold())
                .foregroundColor(.white)

            Spacer(minLength: 0)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text("Hexidecimal")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            // Aligning all text at the Leading
            .frame(width: rectSize.width * 0.3, alignment: .leading)

        }
        .padding([.leading, .vertical], 15)
        .frame(maxHeight: .infinity, alignment: expandCard ? .top : .center)
        .matchedGeometryEffect(id: item.id.uuidString + "DETAILS", in: animation)
    }

    // Custom Progress View
    @ViewBuilder
    func CustomProgressView(value: CGFloat, label: String) -> some View {
        HStack(spacing: 15) {
            Text(label)
                .fontWeight(.semibold)
                .foregroundColor(.white)

            GeometryReader {
                let size = $0.size

                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.black.opacity(0.75))

                    Rectangle()
                        .fill(.white)
                        .frame(width: animateContent ? size.width * value : 0)

                }
            }
            .frame(height: 8)

            Text("\(Int(value * 255.0))")
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }


}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

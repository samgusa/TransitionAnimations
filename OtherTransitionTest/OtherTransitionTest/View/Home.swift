//
//  Home.swift
//  OtherTransitionTest
//
//  Created by Sam Greenhill on 10/16/23.
//

import SwiftUI

struct Home: View {
    // MARK: Animation Properties
    @Namespace var animation
    @State var isExpanded: Bool = false
    @State var expandedProfile: Profile?
    @State var loadExpandedContent: Bool = false
    // MARK: Gesture Properties
    @State var offset: CGSize = .zero

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(profiles) { profile in
                        RowView(profile: profile)
                    }
                }
                .padding()
            }
            .navigationTitle("WhatsApp")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .overlay {
            Rectangle()
                .fill(.black)
                .opacity(loadExpandedContent ? 1 : 0)
                .opacity(offsetProgress())
                .ignoresSafeArea()
        }
        .overlay {
            if let expandedProfile = expandedProfile, isExpanded {
                ExpandedView(profile: expandedProfile)
            }
        }
    }

    // MARK: Offset Progress
    func offsetProgress() -> CGFloat {
        let progress = offset.height / 100
        if offset.height < 0 {
            return 1
        } else {
            return 1 - (progress < 1 ? progress : 1)
        }
    }

    // MARK: Expanded View
    @ViewBuilder
    func ExpandedView(profile: Profile) -> some View {
        VStack {
            GeometryReader { proxy in
                let size = proxy.size

                Image(profile.profilePicture)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                // If we use clip it will clip image from transition
                // to avoid immediate clip relase applying corner radius
                    .cornerRadius(loadExpandedContent ? 0 : size.height)
                // if we use it after clip it will un position the view
                    .offset(y: loadExpandedContent ? offset.height : .zero)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                offset = value.translation
                            }).onEnded({ value in
                                let height = value.translation.height
                                if height > 0 && height > 100 {
                                    // MARK: Closing View
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        loadExpandedContent = false
                                    }
                                    withAnimation(.easeInOut(duration: 0.4).delay(0.05)) {
                                        isExpanded = false
                                    }
                                    // MARK: Resetting After Animation completes
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        offset = .zero
                                    }
                                } else {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        offset = .zero
                                    }
                                }
                            })
                    )
            }
            // Workaround wrap it inside geometry reader and apply before frame
            .matchedGeometryEffect(id: profile.id, in: animation)
            .frame(height: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top, content: {
            HStack(spacing: 10) {
                Button {

                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundStyle(.white)
                }

                Text(profile.username)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)

                Spacer(minLength: 10)
            }
            .padding()
            .opacity(loadExpandedContent ? 1 : 0)
            .opacity(offsetProgress())
        })
        // For more clean transition use transition with offset
        .transition(.offset(x: 0, y: 1))
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                loadExpandedContent = true
            }
        }
    }

    // MARK: Profile Row View
    @ViewBuilder
    func RowView(profile: Profile) -> some View {
        HStack(spacing: 12) {
            VStack {
                if expandedProfile?.id == profile.id && isExpanded {
                    Image(profile.profilePicture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .cornerRadius(0)
                        .opacity(0)
                } else {
                    Image(profile.profilePicture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .matchedGeometryEffect(id: profile.id, in: animation)
                        .cornerRadius(25)
                }
            }
                .onTapGesture {
                    withAnimation {
                        isExpanded = true
                        expandedProfile = profile
                    }
                }

            VStack(alignment: .leading, spacing: 6, content: {
                Text(profile.username)
                    .font(.callout)
                    .fontWeight(.semibold)

                Text(profile.lastMsg)
                    .font(.caption2)
                    .foregroundStyle(.gray)
            })
            .frame(maxWidth: .infinity, alignment: .leading)

            Text(profile.lastActive)
                .font(.caption2)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView3.swift
//  CustomTransitionTest
//
//  Created by Sam Greenhill on 6/14/23.
//

import SwiftUI

struct ContentView3: View {
    @Namespace var namespace
    @State var show = false
    
    var body: some View {
        ZStack {
            if !show {
                View1(namespace: namespace, show: $show)
            } else {
                View2(namespace: namespace, show: $show)
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}

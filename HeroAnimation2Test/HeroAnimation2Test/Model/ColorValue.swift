//
//  ColorFile.swift
//  HeroAnimation2Test
//
//  Created by Sam Greenhill on 6/13/23.
//

import Foundation
import SwiftUI

//MARK: Color model and sample Color

struct ColorValue: Identifiable, Hashable, Equatable {
    var id: UUID = .init()
    var colorCode: String
    var title: String
    var color: Color
}

var colors: [ColorValue] = [
    .init(colorCode: "5F27CD", title: "Warm Purple", color: Color("Warm Purple")),
    .init(colorCode: "222F34", title: "Imperial Black", color: Color("Imperial Black")),
    .init(colorCode: "E15F41", title: "Old Rose", color: Color("Old Rose")),
    .init(colorCode: "786FA6", title: "Mountain View", color: Color("Mountain View")),
    .init(colorCode: "EE5253", title: "Armor Red", color: Color("Armor Red")),
    .init(colorCode: "05C46B", title: "Orc Skin", color: Color("Orc Skin"))
]

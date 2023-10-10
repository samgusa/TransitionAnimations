//
//  Today.swift
//  HeroAnimationTest
//
//  Created by Sam Greenhill on 6/12/23.
//

import Foundation

struct Today: Identifiable {
    var id = UUID().uuidString
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artwork: String
}

var todayItems: [Today] = [
    Today(appName: "LEGO Brawl", appDescription: "Battle with friends online", appLogo: "Logo1", bannerTitle: "Smash your rivals in Lego Brawls", platformTitle: "Apple Arcade", artwork: "Post1"),
    Today(appName: "Forza Horizon", appDescription: "Racing Game", appLogo: "Logo2", bannerTitle: "You're in charge of the Horizon Festival", platformTitle: "Apple Arcade", artwork: "Post2")
]

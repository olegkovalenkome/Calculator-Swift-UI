//
//  CalculetorButton.swift
//  Calculator
//
//  Created by Oleg Kovalenko on 28.11.2019.
//  Copyright © 2019 Oleg Kovalenko. All rights reserved.
//

import Foundation
import SwiftUI

struct CalculatorButton: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var color = Color(red: 0.2, green: 0.2, blue: 0.2)
}

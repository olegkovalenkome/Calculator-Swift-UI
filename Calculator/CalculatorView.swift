//
//  CalculatorView.swift
//  Calculator
//
//  Created by Oleg Kovalenko on 27.11.2019.
//  Copyright © 2019 Oleg Kovalenko. All rights reserved.
//

import SwiftUI

struct CalculatorView: View {
    let buttons: [[CalculatorButton]] = [
        [.init(title: "AC", color: .lightGray),
         .init(title: "±", color: .lightGray),
         .init(title: "%", color: .lightGray),
         .init(title: "÷", color: Color.orange)],
        [.init(title: "7"),
         .init(title: "8"),
         .init(title: "9"),
         .init(title: "x", color: Color.orange)],
        [.init(title: "4"),
         .init(title: "5"),
         .init(title: "6"),
         .init(title: "-", color: Color.orange) ],
        [.init(title: "1"),
         .init(title: "2"),
         .init(title: "3"),
         .init(title: "+", color: Color.orange)],
        [.init(title: "0"),
         .init(title: "."),
         .init(title: "=", color: Color.orange)]
    ]
        
    @ObservedObject var calculatorVM = CalculatorViewModel()
    let spacing: CGFloat = 12
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack(spacing: self.spacing) {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(self.calculatorVM.display)
                            .foregroundColor(Color.white)
                            .font(.system(size: 74))
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.horizontal, self.spacing)
                    
                    ForEach(self.buttons, id: \.self) { row in
                        CalculatorButtonRow(screenWidth: geometry.size.width,
                                            spacing: self.spacing,
                                            buttons: row,
                                            pressedOperator: self.calculatorVM.pressedOperator,
                                            didTapButton: {
                                                calcButton in
                                                    self.calculatorVM.receiveButtonPress(button: calcButton)
                                            })
                    }
                    
                }
                .frame(width: geometry.size.width)
                .background(Color.black)
            }
        }.edgesIgnoringSafeArea(.leading)
    }
}

struct CalculatorButtonRow: View {
    
    let screenWidth: CGFloat
    let spacing: CGFloat
    let buttons: [CalculatorButton]
    let pressedOperator: String
    
    var didTapButton: (CalculatorButton) -> ()
    
    func getButtonWidth(title: String) -> CGFloat {
        return title != "0" ? (self.screenWidth - self.spacing * 5) / 4 :
            (self.screenWidth - self.spacing * 5) / 4 * 2 + self.spacing
    }
    
    var body: some View {
        HStack(spacing: self.spacing) {
            ForEach(self.buttons) { button in
                Button(action: {
                    self.didTapButton(button)
                }, label: {
                    Text(button.title)
                        .frame(width: self.getButtonWidth(title: button.title),
                               height: (self.screenWidth - self.spacing * 5) / 4)
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .background(button.color)
                        .foregroundColor(button.title == self.pressedOperator ? .orange : .white)
                        .background(button.title == self.pressedOperator ? .white : button.color)
                        .cornerRadius(100)
                })
            }
        }
    }
}

//MARK: Colors
extension Color {
    static let lightGray = Color(red: 0.6, green: 0.6, blue: 0.6)
    static let darkGray = Color(red: 0.2, green: 0.2, blue: 0.2)
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

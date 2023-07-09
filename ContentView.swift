//
//  ContentView.swift
//  CalcFun
//


import SwiftUI

struct ContentView: View {
    @State private var displayText = "0"

    let buttons = [
        ["C", "±", "%", "⌫"],
        ["7", "8", "9", "÷"],
        ["4", "5", "6", "×"],
        ["1", "2", "3", "-"],
        ["0", ".", "+", "="],
    ]

    var body: some View {
        VStack(spacing: 10) {
            Text(displayText)
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)

            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.title)
                                .frame(width: buttonWidth(), height: buttonHeight())
                                .background(buttonBackgroundColor(for: button))
                                .foregroundColor(buttonForegroundColor(for: button))
                                .cornerRadius(buttonWidth() / 2)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func buttonBackgroundColor(for button: String) -> Color {
        switch button {
        case "C", "±", "%", "⌫":
            return Color.white
        case "+", "=", "÷", "×","-":
            return Color.red
        default:
            return Color.blue
        }
    }
    
    func buttonForegroundColor(for button: String) -> Color {
        switch button {
        case "C", "±", "%", "⌫", "+", "=", "÷", "×", "-":
            return Color.black
        default:
            return Color.white
        }
    }
    func buttonTapped(_ button: String) {
        switch button {
        case "=":
            calculateResult()
        case "÷":
            appendOperator("/")
        case "×":
            appendOperator("*")
        case "-":
            appendOperator("-")
        case "+":
            appendOperator("+")
        case "C":
            clearDisplay()
        case "⌫":
            deleteLastCharacter()
        case "%":
                 calculatePercentage()
    
        case "±":
                 toggleNegation()
        default:
            appendDigit(button)
        }
    }
    func calculatePercentage() {
        guard let value = Double(displayText) else { return }
        let percentage = value / 100.0
        displayText = String(percentage)
    }

    func toggleNegation() {
        guard let value = Double(displayText) else { return }
        let negatedValue = -value
        displayText = String(negatedValue)
    }

    func clearDisplay() {
        displayText = "0"
    }

    func deleteLastCharacter() {
        guard !displayText.isEmpty else { return }
        displayText.removeLast()
    }

    func appendDigit(_ digit: String) {
        if displayText == "0" {
            displayText = digit
        } else {
            displayText += digit
        }
    }

    func appendOperator(_ operatorSymbol: String) {
        displayText += operatorSymbol
    }

    func calculateResult() {
        let expression = NSExpression(format: displayText)
        if let result = expression.expressionValue(with: nil, context: nil) as? Double {
            displayText = String(result)
        }
    }
   

    func buttonWidth() -> CGFloat {
        (UIScreen.main.bounds.width - 5 * 10) / 4
    }

    func buttonHeight() -> CGFloat {
        (UIScreen.main.bounds.height - 15 * 10) / CGFloat(buttons.count + 1)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  NumFormatter.swift
//  AdwumaX
//
//  Created by Denis on 5/10/24.
//
import Foundation
import Combine
import SwiftUI

struct NumFormatter: View {
    @StateObject private var viewModel = FormatterViewModel()

    var body: some View {
        VStack {
            // Text field
            TextField("Enter number", text: $viewModel.text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)

            // Buttons for selecting format
            HStack {
                ForEach(1...3, id: \.self) { format in
                    Button(action: {
                        viewModel.selectedFormat = format
                    }) {
                        Text("Option \(format)")
                            .foregroundColor(viewModel.selectedFormat == format ? .white : .blue)
                            .padding()
                            .background(viewModel.selectedFormat == format ? Color.blue : Color.clear)
                            .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    NumFormatter()
}


class FormatterViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var selectedFormat: Int = 1

    private var cancellables = Set<AnyCancellable>()

    init() {
        $text
            .combineLatest($selectedFormat)
            .map { text, format -> String in
                self.formatText(text, with: format)
            }
            .assign(to: \.text, on: self)
            .store(in: &cancellables)
    }

    private func formatText(_ text: String, with format: Int) -> String {
        let numericText = text.filter { $0.isNumber }
        switch format {
        case 1:
            return self.applyPattern(numericText, pattern: "### ### ####", replacer: "#")
        case 2:
            return self.applyPattern(numericText, pattern: "### ### ###", replacer: "#")
        case 3:
            return self.applyPattern(numericText, pattern: "## ## ####", replacer: "#")
        default:
            return numericText
        }
    }

    private func applyPattern(_ text: String, pattern: String, replacer: Character) -> String {
        var result = ""
        var index = text.startIndex
        for ch in pattern where index < text.endIndex {
            if ch == replacer {
                result.append(text[index])
                index = text.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

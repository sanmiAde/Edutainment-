//
//  StepperView.swift
//  Edutainment
//
//  Created by sanmi_personal on 18/04/2021.
//

import SwiftUI

struct StepperView: View {
    @State var title: String
    @Binding var selectedOption : Int
    var range: ClosedRange<Int>
    
    var body: some View {
        Stepper(title, value: $selectedOption, in: range)
        Text("\(title): \(selectedOption)")
    }
}

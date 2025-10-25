//
//  FormTextField.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import SwiftUI

struct FormTextField: View {
  
  @Binding var value: String
  
  let label: String
  var placeholder: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(label.uppercased())
        .font(.system(.headline, design: .rounded))
        .foregroundStyle(Color(.darkGray))
      
      TextField(placeholder, text: $value)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
        .padding(.horizontal)
        .padding(8)
        .overlay {
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color(.systemGray5), lineWidth: 1)
        }
    }
  }
}

#Preview {
  FormTextField(value: .constant("Restaurant name"), label: "Name", placeholder: "Enter restaurant name")
}

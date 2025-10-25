//
//  FormTextView.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import SwiftUI

struct FormTextView: View {
  
  @Binding var value: String
  
  let label: String
  var height: CGFloat = 200.0
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(label.uppercased())
        .font(.system(.headline, design: .rounded))
        .foregroundStyle(Color(.darkGray))
      
      TextEditor(text: $value)
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .padding(10)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .padding(.top, 10)
      
    }
  }
}

#Preview {
  FormTextView(value: .constant(""), label: "Description")
}

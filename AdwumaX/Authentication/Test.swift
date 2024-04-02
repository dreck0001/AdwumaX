//
//  Test.swift
//  Adwumax1
//
//  Created by Denis on 3/22/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct Test: View {
    @Environment(\.colorScheme) var colorScheme
    
    // Your contact or profile URL
    let profileURL = "https://www.techinnovations.com/janedoe"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 15)
                
                VStack(alignment: .leading) {
                    Text("Danqueezy Squeezy")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    Text("iOS Developer")
                        .font(.body)
                        .foregroundColor(Color.secondary)
                }
                
                Spacer()
                
                // Generate and display the QR code
                Image(uiImage: generateQRCode(from: profileURL))
                    .resizable()
                    .interpolation(.none) // Keeps the QR code sharp at any size
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            }
            
            Divider()
            
            InfoRow(label: "Company:", value: "Tech Innovations Inc.")
            InfoRow(label: "Email:", value: "jane.doe@email.com")
            InfoRow(label: "Phone:", value: "+123 456 7890")
            InfoRow(label: "Website:", value: "www.techinnovations.com")
            
            Text("Elevator Pitch:")
                .fontWeight(.bold)
                .foregroundColor(Color.secondary)
                .padding(.top, 5)

            Text("Passionate iOS Developer with 5+ years of experience crafting mobile solutions that enhance user experience and business growth. Excited to leverage skills in Swift and SwiftUI to build next-generation apps.")
                .foregroundColor(Color.primary)
                .padding(.top, 2)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(colorScheme == .dark ? Color.black : Color.white)
            .shadow(color: colorScheme == .dark ? .clear : .gray.opacity(0.4), radius: 5, x: 0, y: 2))
        .padding(.horizontal)
    }
    
    // Inline QR code generation function
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }

        // Return a default image if QR code generation fails
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct InfoRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.bold)
                .foregroundColor(Color.secondary)
            Text(value)
                .foregroundColor(Color.primary)
            Spacer()
        }
    }
}

//struct SleekBusinessCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            SleekBusinessCardView().preferredColorScheme(.light)
//            SleekBusinessCardView().preferredColorScheme(.dark)
//        }
//    }
//}



#Preview {
    Group {
        Test().preferredColorScheme(.light)
        Test().preferredColorScheme(.dark)
    }
}

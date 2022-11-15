//
//  Extentions.swift
//  iceberg-dash
//
//  Created by yury mid on 05.11.2022.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins
import CodeScanner
import UniformTypeIdentifiers
import Drops


extension Color {
    static let bg = Color("BgColor")
    static let bgSec = Color("SecondaryBgColor")
    static let text = Color("TextColor")
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension String {
    static func localizedString(for key: String,
                                locale: Locale = .current) -> String {
        
        let language = locale.language.languageCode!.identifier
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        
        return localizedString
    }
    

}


extension Array where Element: Equatable {
    mutating func remove(object: Element) {
         guard let index = firstIndex(of: object) else {return}
         remove(at: index)
    }
}
extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
    
    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.stringKey ?? "", locale: locale)
        }
}

extension View {
    
    func formatPhoneNumber(with mask: String, phone: String) -> String {
            let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            var result = ""
            var index = numbers.startIndex
            
            for ch in mask where index < numbers.endIndex {
                if ch == "X" {
                    result.append(numbers[index])
                    
                    index = numbers.index(after: index)
                    
                } else {
                    result.append(ch)
                }
            }
            return result
        }
    
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func unixTimeConverter(ts: Double)->String{
        let date = NSDate(timeIntervalSince1970: ts)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "hh:mm dd MMM YY"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    func copyTextToClipboard(string: String) {
        UIPasteboard.general.setValue(string,
                forPasteboardType: UTType.plainText.identifier)
        
        haptic()
        
        Drops.show(
            Drop(
                title: LocalizedStringKey("Copied").stringValue(),
                icon: UIImage(systemName: "doc.on.clipboard.fill"),
                action: .init {
                    Drops.hideCurrent()
                },
                position: .top,
                duration: 3.0,
                accessibility: "Alert: Title, Subtitle"
            )
        )
    }
    
    func haptic(force: Int = 0) {
        var impact: UIImpactFeedbackGenerator
        
        switch force {
            case 1:
                impact = UIImpactFeedbackGenerator(style: .rigid)
            case 2:
                impact = UIImpactFeedbackGenerator(style: .light)
            case 3:
                impact = UIImpactFeedbackGenerator(style: .medium)
            case 4:
                impact = UIImpactFeedbackGenerator(style: .heavy)
            default:
                impact = UIImpactFeedbackGenerator(style: .soft)
        }

        impact.impactOccurred()
    }
}



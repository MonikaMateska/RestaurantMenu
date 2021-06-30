import Foundation
import SwiftUI

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Date {
    
    /// Converts the date to a String with `"MMM dd,yyyy` format and returns it.
    ///
    /// - Returns: The converted date as String.
    public func toString() -> String {
        return stringValue(withDateFormat: "MMM dd,yyyy")
    }
    
    private func stringValue(withDateFormat dateFormat:String) -> String {
        let dateFormatter = Date.dateFormatter(withFormat: dateFormat)
        return dateFormatter.string(from: self)
    }
    
    /// Returns a date formatter with a given format.
    ///
    /// - Parameter format: The format used by the date formatter.
    /// - Returns: A DateFormatter object.
    static public func dateFormatter(withFormat format:String) -> DateFormatter {
        let currentThread = Thread.current
        let threadDictionary = currentThread.threadDictionary
        
        var formatter: DateFormatter? = threadDictionary.object(forKey: format) as? DateFormatter
        if formatter == nil {
            // "en_US_POSIX" is a locale that's specifically designed to yield US English results,
            // regardless of both user and system preferences
            let enUsPosix = Locale(identifier: "en_US_POSIX")
            formatter = DateFormatter()
            formatter!.locale = enUsPosix
            formatter!.timeZone = TimeZone(secondsFromGMT: 0)
            formatter!.dateFormat = format
            threadDictionary.setObject(formatter!, forKey: format as NSCopying)
        }
        
        return formatter!
    }
}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

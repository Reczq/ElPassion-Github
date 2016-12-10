
import UIKit

extension UISearchBar {

    func getTextField() -> UITextField? {
        return value(forKey: "searchField") as? UITextField
    }

    func textColor(color: UIColor) {
        getTextField()?.textColor = color
    }
}

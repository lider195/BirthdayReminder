import UIKit

extension UITextField {
    func setInputDatePicker(target: Any, selector: Selector) {
        let screenWigth = UIScreen.main.bounds.width

        let datePickers = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWigth,
                                                    height: 220))
        datePickers.datePickerMode = .time
        
        
        
        if #available(iOS 14, *) {
            datePickers.preferredDatePickerStyle = .wheels
            datePickers.locale = Locale(identifier: "ru_RU")
            datePickers.sizeToFit()
        }
        inputView?.backgroundColor = AppColor.viewBackgroundColor
        inputView = datePickers
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWigth,
                                              height: 44))
        let spacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                      target: nil,
                                      action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem:.cancel ,
                                     target: nil,
                                     action: #selector(cancel))

        let done = UIBarButtonItem(barButtonSystemItem: .done,
                                   target: target,
                                   action: selector)

        toolBar.backgroundColor = AppColor.viewBackgroundColor
        toolBar.setItems([cancel, spacing, done], animated: false)
        inputAccessoryView = toolBar
    }

    @objc func cancel() {
        resignFirstResponder()
    }
}

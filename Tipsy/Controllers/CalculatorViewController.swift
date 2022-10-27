
import UIKit

class CalculatorViewController: UIViewController {
    
    override func viewDidLoad() {
        tenPctButton.isSelected = false
    }
   
    
    var buttonSelected: String?

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var billValue = 0.0
    var personsToSplit = 2.0
    var bill = ""
    var infoText = ""
    var tipToText = ""
    @IBAction func billValueCompleted(_ sender: UITextField) {
        billValue = Double(sender.text ?? "0.0")!
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        buttonSelected = sender.currentTitle
        tipToText = sender.currentTitle!
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tip = buttonTitleAsANumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        print(sender.value)
        splitNumberLabel.text = String(Int(sender.value))
        personsToSplit = sender.value
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        let total = (billValue + (billValue * tip)) / personsToSplit
        let billToTwoDecPLaces = String(format: "%.2f", total)
        bill = billToTwoDecPLaces
        let personsToZeroDecPlace = String(format: "%.0f", personsToSplit)
        infoText = "Split between \(personsToZeroDecPlace) people, with \(tipToText) tip."
        performSegue(withIdentifier: "GoToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToResult" {
            let secondVC = segue.destination as! ResultsViewController
            secondVC.billValue = bill
            secondVC.infoText = infoText
        }
    }
}




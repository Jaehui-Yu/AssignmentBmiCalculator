//
//  ViewController.swift
//  AssignmentBmiCalculator
//
//  Created by Jaehui Yu on 1/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var heightResultLabel: UILabel!

    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var weightResultLabel: UILabel!
    
    @IBOutlet var resultButton: UIButton!
    
    var height = 0.0
    var weight = 0.0
    var bmiString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = "BMI Calculator"
        mainLabel.font = .boldSystemFont(ofSize: 30)
        
        subLabel.text = "당신의 BMI 지수를 알려드릴게요"
        subLabel.numberOfLines = 2
        
        posterImageView.image = UIImage(named: "image")
        
        heightLabel.text = "키를 입력해주세요"
        weightLabel.text = "몸무게를 입력해주세요"
        
        resultButton.setTitle("계산하기", for: .normal)
        resultButton.tintColor = .white
        resultButton.layer.cornerRadius = 10
        
        changedButton()
        
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func inputHeight(_ sender: UITextField) {
        guard let text = heightTextField.text else {
            print("옵셔널 바인딩 오류")
            return
        }
        if let height = Double(text) {
            if height > 230 || height < 30 {
                heightResultLabel.text = "계산할 수 없는 키입니다."
                heightResultLabel.textColor = .red
                self.height = height
            } else {
                heightResultLabel.text = "키 : \(height)cm"
                heightResultLabel.textColor = .black
                self.height = height
            }
        } else {
            heightResultLabel.text = "숫자와 .만 입력 가능합니다."
            heightResultLabel.textColor = .red
        }
    }
    
    @IBAction func inputWeight(_ sender: UITextField) {
        guard let text = weightTextField.text else {
            print("옵셔널 바인딩 오류")
            return
        }
        if let weight = Double(text) {
            if weight > 200 || weight < 5 {
                weightResultLabel.text = "계산할 수 없는 몸무게입니다."
                weightResultLabel.textColor = .red
                self.weight = weight
            } else {
                weightResultLabel.text = "몸무게: \(weight)kg"
                weightResultLabel.textColor = .black
                self.weight = weight
            }
        } else {
            weightResultLabel.text = "숫자와 .만 입력 가능합니다."
            weightResultLabel.textColor = .red
        }
    }
    
    @IBAction func changedTextField(_ sender: UITextField) {
        changedButton()
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        height = height / 100
        let bmi = weight / (height * height)
        
        switch bmi {
        case ..<18.5: bmiString = "저체중"
        case 18.5..<23: bmiString = "정상"
        case 23..<25: bmiString = "과체중"
        case 25...: bmiString = "비만"
        default: print("error")
        }
        
        let alert = UIAlertController(title: "당신의 BMI는 \(bmiString)입니다.", message: "입력한 키: \(height), 몸무게: \(weight)", preferredStyle: .alert)
        let oneButton = UIAlertAction(title: "완료", style: .cancel)
        alert.addAction(oneButton)
        present(alert, animated: true)
        
        reset()
        
    }
    
    func changedButton() {
        if height > 30 && height < 230 && weight > 5 && weight < 200 {
            resultButton.isEnabled = true
            resultButton.backgroundColor = .purple
        } else {
            resultButton.isEnabled = false
            resultButton.backgroundColor = .gray.withAlphaComponent(0.3)
        }
    }
    
    func reset() {
        height = 0.0
        weight = 0.0
        heightTextField.text = ""
        weightTextField.text = ""
        heightResultLabel.text = ""
        weightResultLabel.text = ""
        changedButton()
    }
}


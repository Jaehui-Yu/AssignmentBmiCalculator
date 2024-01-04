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
    
    var bmiString = ""
    let defaults = UserDefaults.standard
    
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
        resultButton.backgroundColor = .purple
        resultButton.tintColor = .white
        resultButton.layer.cornerRadius = 10
                
        heightTextField.text = "\(defaults.double(forKey: "Height"))"
        weightTextField.text = "\(defaults.double(forKey: "Weight"))"
        
        setNavigationItem()
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
                defaults.set(heightTextField.text, forKey: "Height")
                changedLabel(heightResultLabel, text: "계산할 수 없는 키입니다.", color: UIColor.red)
            } else {
                defaults.set(heightTextField.text, forKey: "Height")
                changedLabel(heightResultLabel, text: "몸무게: \(height)kg", color: UIColor.black)
            }
        } else {
            changedLabel(heightResultLabel, text: "숫자와 .만 입력 가능합니다.", color: UIColor.red)
        }
    }
    
    @IBAction func inputWeight(_ sender: UITextField) {
        guard let text = weightTextField.text else {
            print("옵셔널 바인딩 오류")
            return
        }
        if let weight = Double(text) {
            if weight > 200 || weight < 5 {
                defaults.set(weightTextField.text, forKey: "Weight")
                changedLabel(weightResultLabel, text: "계산할 수 없는 몸무게입니다.", color: UIColor.red)
            } else {
                defaults.set(weightTextField.text, forKey: "Weight")
                changedLabel(weightResultLabel, text: "몸무게: \(weight)kg", color: UIColor.black)
            }
        } else {
            changedLabel(weightResultLabel, text: "숫자와 .만 입력 가능합니다.", color: UIColor.red)
        }
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        let userHeight = defaults.double(forKey: "Height")
        let userWeight = defaults.double(forKey: "Weight")
        
        let height = userHeight / 100
        let bmi = userWeight / (height * height)
        
        switch bmi {
        case ..<18.5: bmiString = "저체중"
        case 18.5..<23: bmiString = "정상"
        case 23..<25: bmiString = "과체중"
        case 25...: bmiString = "비만"
        default: print("error")
        }
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        if userHeight > 30.0 && userHeight < 230.0 && userWeight > 5.0 && userWeight < 200.0 {
            alert.title = "당신의 BMI는 \(bmiString)입니다."
            alert.message = "입력한 키: \(userHeight), 몸무게: \(userWeight)"
        } else {
            alert.title = "잘못된 값을 입력하셨습니다."
            alert.message = "키와 몸무게를 정확히 입력해주세요"
        }
        
        let oneButton = UIAlertAction(title: "완료", style: .cancel)
        alert.addAction(oneButton)
        present(alert, animated: true)
                
    }
    
    func changedLabel(_ label: UILabel, text: String, color: UIColor) {
        label.text = text
        weightResultLabel.textColor = color
    }
    
    func setNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .purple
    }
    
    @objc func rightBarButtonClicked() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        
        heightTextField.text = ""
        weightTextField.text = ""
        heightResultLabel.text = ""
        weightResultLabel.text = ""
    }
}


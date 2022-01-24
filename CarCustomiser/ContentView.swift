//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Clyde Lartey on 14/01/2022.
//


import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        
        didSet{
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    
    @State private var money = 1000
    @State private var remainingTime = 30
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var drivetrainPackage = false
    @State private var fuelPackage = false
    @State private var timerOver = false
    
    
    
    
    
    
    var isExhaustPackageActivated: Bool {
        return exhaustPackage ? true : money >= 500 ? true : false
    }
    
    var isTiresPackageActivated: Bool {
        return tiresPackage ? true : money >= 500 ? true : false
    }
    
    var isDrivetrainPackageActivated: Bool {
        return drivetrainPackage ? true : money >= 500 ? true : false
    }
    
    var isFuelPackageActivated: Bool {
        return fuelPackage ? true : money >= 500 ? true : false
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    
    
    
    
    
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: {newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    money -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    money += 500

                }
            }
        )
        
        
        
        
        
        
        
        
        
        
        let tiresPackageBinding = Binding<Bool> (
            get: {self.tiresPackage},
            set: {newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    money -= 500
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    money += 500

                }
            }
        )
        
        
        
        
        
       
        let fuelPackageBinding = Binding<Bool> (
            get: {self.fuelPackage},
            set: {newValue in
                self.fuelPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 2
                    starterCars.cars[selectedCar].acceleration -= 0.1
                    money -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 2
                    starterCars.cars[selectedCar].acceleration += 0.1
                    money += 500
                }
            }
        )
        
        
        
        
        
        
        
        
        
        let drivetrainPackageBinding = Binding<Bool> (
            get: {self.drivetrainPackage},
            set: {newValue in
                self.drivetrainPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 2.5
                    money -= 500
                } else {
                    starterCars.cars[selectedCar].acceleration += 2.5
                    money += 500
                }
            }
        )
        
        
        
        
        
        
        
        VStack {
            Text("\(remainingTime)")
                .onReceive(timer) {_ in
                    if self.remainingTime > 0 {
                        self.remainingTime -= 1
                    } else {
                        timerOver = true
                    }
                }
                .foregroundColor(.red)
            Form {
                VStack (alignment: .leading, spacing: 20){
                    Text("\(starterCars.cars[selectedCar].displayStats())")
                    Button("Next Car", action: {
                            selectedCar += 1
                            resetDisplay()
                    })
                        .disabled(timerOver)
                }
                
                
                
                
                
                
                
                
                
                Section {
                    Toggle("Exhaust Package - 500", isOn: exhaustPackageBinding)
                        .disabled(!isExhaustPackageActivated || timerOver)
                    Toggle("Tires Package - 500", isOn: tiresPackageBinding)
                        .disabled(!isTiresPackageActivated || timerOver)
                    Toggle("Fuel Package - 500", isOn: fuelPackageBinding)
                        .disabled(!isFuelPackageActivated || timerOver)
                    Toggle("Drivetrain Package - 500", isOn: drivetrainPackageBinding)
                        .disabled(!isDrivetrainPackageActivated || timerOver)
                }
                
                
                
                .accessibilityIdentifier(/*@START_MENU_TOKEN@*/"Identifier"/*@END_MENU_TOKEN@*/)
                .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                .accessibilityValue(/*@START_MENU_TOKEN@*/"Value"/*@END_MENU_TOKEN@*/)
                .accessibilityHint(/*@START_MENU_TOKEN@*/"Hint"/*@END_MENU_TOKEN@*/)
                .accessibilityElement(children: /*@START_MENU_TOKEN@*/.contain/*@END_MENU_TOKEN@*/)
                
                
                
                
            }
            Text("Remaining Funds: \(money)")
                .foregroundColor(.red)
                .baselineOffset(20)
        }
    }
    
    
    
    
    
    func resetDisplay() {
        money = 1000
        starterCars = StarterCars()
        exhaustPackage = false
        tiresPackage = false
        drivetrainPackage = false
        fuelPackage = false
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

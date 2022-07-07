//
//  BiometricAuth.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 05/07/22.
//

import Foundation
import LocalAuthentication

final class BiometricAuth {
    let faceIDState = UserDefaults.standard.bool(forKey: "switchState")
    func setBiometricAuth() {
        if faceIDState == true {
            let context:LAContext = LAContext()
            if context.canEvaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                error: nil) { context.evaluatePolicy (
                    LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: "Membutuhkan Face ID Kamu untuk login",
                    reply: { (wascorrect, error) in
                        if wascorrect {
                            print("Correct")
                        } else {
                            print("Wrong")
                        }
                    })
            } else {
                print("Tidak dapat mengakses otentikasi")
            }
        } else {
            return
        }
    }
}

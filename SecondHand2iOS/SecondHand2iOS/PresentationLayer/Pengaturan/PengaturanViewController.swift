//
//  PengaturanViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 28/06/22.
//
import LocalAuthentication
import UIKit

final class PengaturanViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    @IBAction func authenticateUser(_ sender: Any) {
        let context:LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        {
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Membutuhkan Face ID Kamu untuk login", reply: {(wascorrect, error) in
            if wascorrect
        {
            print("Benar")
        }
        else
        {
            print("Salah")
        }
    })
}
else
{
    print("Tidak dapat mengakses otentikasi")
}
    }}

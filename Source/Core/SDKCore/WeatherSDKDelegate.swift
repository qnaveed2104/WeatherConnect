//
//  WeatherSDKDelegate.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

/// A protocol used to inform the delegate about the completion status of the WeatherCore operation.
/// The delegate will be notified whether the SDK operation finished successfully or with an error.
public protocol WeatherSDKDelegate: AnyObject {
    
    /// Called when the Weather SDK operation finishes successfully without any errors.
    ///
    /// This method is invoked when the use tap on close/back button and it ends without erroe.
    func onFinished()
    
    /// Called when the Weather SDK operation finishes with an error.
    ///
    /// This method is invoked if the SDK encounters an error during its task.
    /// The delegate should handle the error appropriately,
    ///  such as showing an error message to the user or attempting recovery.
    
    /// - Parameter error: The error that occurred during the SDK operation.
    func onFinishedWithError(_ error: Error)
}

//
//  AppStateView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

enum AppState<T> {
    case failed(AppError)
    case empty
    case loading
    case success(T)
    case idle
}

// Protocol for objects that have a view state
protocol AppStateProtocol: ObservableObject {
    associatedtype ContentType
    var state: AppState<ContentType> { get }
}

struct AppStateView<Content: View,
                     EmptyView: View,
                     ErrorView: View,
                     IdleView: View,
                     LoadingView: View,
                     T>: View {
    let state: AppState<T>
    let content: (T) -> Content
    let emptyView: () -> EmptyView
    let errorView: (Error) -> ErrorView
    let idleView: () -> IdleView
    let loadingView: () -> LoadingView
    
    init(
        state: AppState<T>,
        content: @escaping (T) -> Content,
        emptyView: @escaping () -> EmptyView = { DefaultEmptyView() },
        errorView: @escaping (Error) -> ErrorView = { error in DefaultErrorView(error: error) },
        idleView: @escaping () -> IdleView = { DefaultIdleView() },
        loadingView: @escaping () -> LoadingView = { DefaultLoadingView() }
    ) {
        self.state = state
        self.content = content
        self.emptyView = emptyView
        self.errorView = errorView
        self.idleView = idleView
        self.loadingView = loadingView
    }
    
    var body: some View {
        switch state {
        case .idle:
            idleView()
        case .loading:
            loadingView()
        case .success(let data):
            content(data)
        case .empty:
            emptyView()
        case .failed(let error):
            errorView(error)
        }
    }
}

/*
 ViewStateView(
 state: viewModel.state,
 content: { object in
 Text("Objects: \(object.count)")
 }
 // Override only the views you want to customize
 // Leave out others to use defaults
 // emptyView: { CustomEmptyView() },
 // errorView: { CustomErrorView(error: $0) }
 // idleView: { CustomIdleView() },
 // loadingView: { CustomLoadingView() }
 )
 */

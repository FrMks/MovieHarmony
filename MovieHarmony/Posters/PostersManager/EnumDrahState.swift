//
//  EnumDrahState.swift
//  MovieHarmony
//
//  Created by Максим Французов on 05.04.2024.
//

import Foundation

enum DragState {
    case inactive //неактивное состояние, когда никакие жесты не выполняются
    case pressing //состояние, когда пользователь начинает нажимать на карточку
    case dragging(translation: CGSize) //состояние, когда пользователь перетаскивает карточку. Он также хранит информацию о смещении карточки
    
    var translation: CGSize { //вычисляемое свойств, которое возвращает смещение карточки, в зависимости от текущего состояния
        switch self {
        case .inactive, .pressing: //если состояние неактивно или нажато
            return .zero
        case .dragging(let translation): //если состояние перетаскивания, возвращается значение смещения
            return translation
        }
    }
    
    var isDragging: Bool { //вычисляемое свойство, которое оперделяет, перетаскиванивается ли карточка
        switch self {
        case .dragging:
            return true
        case .inactive, .pressing:
            return false
        }
    }
    
    
    var isPressing: Bool { //вычисляемое свойство, которое оперделяет нажимается ли в данный момент на карточку
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}

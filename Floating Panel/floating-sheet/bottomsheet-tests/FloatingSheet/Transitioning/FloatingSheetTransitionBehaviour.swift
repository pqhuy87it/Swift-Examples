//
//  FloatingSheetTransitionBehaviour.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 28.06.2022.
//

import UIKit
import simd

final class FloatingSheetTransitionBehaviour: NSObject {

    weak var view: FloatingSheetView?
    weak var scrollingBehaviour: FloatingSheetScrollingBehaviour?

    var states: [FloatingSheetState] = []
    var isTransitioning: Bool {
        currentTransition != nil
    }

    private var currentTransition: Transition?
    private let animationDuration: TimeInterval = 0.25
    private let timing = UISpringTimingParameters(damping: 1.0, response: 0.35)

    private func momentumTiming(for initialVelocity: CGVector) -> UISpringTimingParameters {
        UISpringTimingParameters(damping: 0.95, response: 0.35, initialVelocity: initialVelocity)
    }
}

// MARK: - Transitions
extension FloatingSheetTransitionBehaviour {
    func setStateAnimated(to nextState: FloatingSheetState) {
        if let currentTransition = currentTransition {
            let previousTranslation = currentTransition.currentTranslation()
            currentTransition.animator.stopAnimation(true)

            if let newTransition = createNewTransition(to: nextState) {
                let newProgress = newTransition.progress(
                    for: .init(translation: previousTranslation, velocity: .zero)
                )
                newTransition.animator.fractionComplete = newProgress
                newTransition.animator.startAnimation()
            }

        } else {
            let newTransition = createNewTransition(to: nextState)
            newTransition?.animator.startAnimation()
        }
    }

    private func createNewTransition(to nextState: FloatingSheetState) -> Transition? {
        guard let initialState = view?.currentState else { return nil }

        let animator = UIViewPropertyAnimator(
            duration: animationDuration,
            timingParameters: timing
        )
        animator.addAnimations { [weak self] in
            guard let self = self else { return }
            self.view?.updateUI(to: nextState)
        }

        view?.shouldInterceptTap = true

        animator.addCompletion { [weak self] position in
            guard let self = self else { return }

            let updatedState: FloatingSheetState
            switch position {
            case .end:
                updatedState = nextState
            case .start:
                updatedState = initialState
            case .current:
                updatedState = initialState
            @unknown default:
                updatedState = initialState
            }

            self.view?.currentState = updatedState
            self.view?.shouldInterceptTap = false
            self.currentTransition = nil
        }

        let initialPosition = position(for: initialState)

        let currentTransition = Transition(
            animator: animator,
            initialState: initialState,
            initialPosition: initialPosition,
            finalState: nextState,
            finalPosition: position(for: nextState)
        )

        self.currentTransition = currentTransition
        return currentTransition
    }
}

// MARK: - Dragging by gesture
extension FloatingSheetTransitionBehaviour {

    func didPan(state: UIGestureRecognizer.State, gesture: Gesture) {
        switch state {
        case .began:
            print("FloatingSheetTransitionBehaviour.didPan(state: .began)")
            startInteractiveTransition(gesture: gesture)
        case .changed:
            print("FloatingSheetTransitionBehaviour.didPan(state: .changed)")
            updateInteractiveTransition(gesture: gesture)
        case .ended:
            print("FloatingSheetTransitionBehaviour.didPan(state: .ended)")
            finishInteractiveTransition(gesture: gesture, isCanceled: false)
        case .cancelled, .failed:
            print("FloatingSheetTransitionBehaviour.didPan(state: .canceled)")
            finishInteractiveTransition(gesture: gesture, isCanceled: true)
        case .possible:
            break
        @unknown default:
            break
        }
    }

    private func startInteractiveTransition(gesture: Gesture) {
        if let currentTransition = currentTransition {
            currentTransition.animator.pauseAnimation()
            currentTransition.animator.isReversed = false
            currentTransition.initialTranslation = currentTransition.currentTranslation()
        } else {
            guard  let nextState = nextExpectedState(for: gesture) else { return }

            let newTransition = createNewTransition(to: nextState)
            newTransition?.animator.pauseAnimation()
        }
    }

    private func updateInteractiveTransition(gesture: Gesture) {
        guard let currentTransition = currentTransition else { return }

        let fractionComplete = currentTransition.progress(for: gesture)
        currentTransition.animator.fractionComplete = fractionComplete
    }

    private func finishInteractiveTransition(gesture: Gesture, isCanceled: Bool) {
        guard let currentTransition = currentTransition else { return }

        let shouldReverseTransition: Bool
        if isCanceled {
            shouldReverseTransition = true
        } else {
            let projectedFinalPosition = currentTransition.projectedPosition(for: gesture)
            let closesState = closestState(
                of: [currentTransition.initialState, currentTransition.finalState],
                to: projectedFinalPosition
            )
            shouldReverseTransition = closesState == currentTransition.initialState
        }

        currentTransition.animator.isReversed = shouldReverseTransition

        let remainedTranslation = currentTransition.currentTranslation()
        if remainedTranslation.y == 0 {
            currentTransition.animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        } else {
            let relativeVelocity = min(abs(gesture.velocity.y), 30)
            let timingParameters = momentumTiming(for: .init(dx: 0, dy: relativeVelocity))
            let preferredDuration = UIViewPropertyAnimator(duration: 0, timingParameters: timingParameters).duration
            let durationFactor = CGFloat(preferredDuration / currentTransition.animator.duration)
            currentTransition.animator.continueAnimation(
                withTimingParameters: timingParameters,
                durationFactor: durationFactor
            )
        }
    }

}

// MARK: - States and positions

extension FloatingSheetTransitionBehaviour {

    func haveTransition(for gesture: Gesture) -> Bool {
        nextExpectedState(for: gesture) != nil
    }

    private func nextExpectedState(for gesture: Gesture) -> FloatingSheetState? {
        guard let currentState = view?.currentState else { return nil }

        let currentPosition = position(for: currentState)

        let possibleStates = states.filter { $0 != currentState }
        let possibleStatesOrderedByY = positionedStates(states: possibleStates)
            .filter { $0.state != currentState }
            .sorted { $0.position.y < $1.position.y }

        var nextState: FloatingSheetState?

        if gesture.velocity.y > 0 {
            nextState = possibleStatesOrderedByY
                .first { $0.position.y > currentPosition.y }
                .map { $0.state }
        }

        if gesture.velocity.y < 0 {
            nextState = possibleStatesOrderedByY
                .reversed()
                .first { $0.position.y < currentPosition.y }
                .map { $0.state }
        }

        return nextState
    }

    private func closestState(of states: [FloatingSheetState], to position: CGPoint) -> FloatingSheetState? {
        let yDistanceTo = { (positionedState: PositionedState) -> CGFloat in
            abs(positionedState.position.y - position.y)
        }
        let closestState = positionedStates(states: states)
            .min { yDistanceTo($0) < yDistanceTo($1) }
            .map { $0.state }

        return closestState
    }

    private func position(for state: FloatingSheetState) -> CGPoint {
        guard let context = view?.currentContext() else { return .zero }
        let frame = state.position.frame(context)
        return frame.origin
    }

    private func positionedStates(states: [FloatingSheetState]) -> [PositionedState] {
        states.map { PositionedState(state: $0, position: position(for: $0)) }
    }
}

// MARK: - Models

extension FloatingSheetTransitionBehaviour {
    private struct PositionedState {
        let state: FloatingSheetState
        let position: CGPoint
    }

    private class Transition {
        let animator: UIViewPropertyAnimator
        var initialTranslation: CGPoint = .zero
        let initialState: FloatingSheetState
        let initialPosition: CGPoint
        let finalState: FloatingSheetState
        let finalPosition: CGPoint


        init(
            animator: UIViewPropertyAnimator,
            initialState: FloatingSheetState,
            initialPosition: CGPoint,
            finalState: FloatingSheetState,
            finalPosition: CGPoint
        ) {
            self.animator = animator
            self.initialState = initialState
            self.initialPosition = initialPosition
            self.finalState = finalState
            self.finalPosition = finalPosition
        }

        func position(for gesture: Gesture) -> CGPoint {
            initialPosition + initialTranslation + gesture.translation
        }

        func currentTranslation() -> CGPoint {
            (finalPosition - initialPosition) * animator.fractionComplete
        }

        func remainedTranslation() -> CGPoint {
            (finalPosition - initialPosition) - currentTranslation()
        }

        func projectedPosition(for gesture: Gesture) -> CGPoint {
            return gesture.projectedStopPoint(for: initialPosition)
        }

        func progress(for gesture: Gesture) -> CGFloat {
            let gesturePosition = position(for: gesture)
            let progress = (gesturePosition.y - initialPosition.y) / (finalPosition.y - initialPosition.y)
            return progress
        }
    }
}

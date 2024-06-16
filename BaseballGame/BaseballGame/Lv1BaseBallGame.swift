//
//  Lv1BaseBallGame.swift
//  BaseballGame
//
//  Created by DEUKRYEONG LEE on 6/14/24.
//

import Foundation
//MARK: - Lv 1
//class BaseballGame {
//
//    func start() {
//        let answer = makeAnswer()
//        print(answer)
//    }
//
//    func makeAnswer() -> Int {
//        return 0
//    }
//
//}

//MARK: - BaseballGame
class BaseballGame {
    //MARK: - 전역변수 선언
    var functionCallCount = 0
    var gameCount = [Int]()
    var currentNumber = 1
    var tryCount = [Int]()
    //MARK: - 랜덤숫자 만들기
    func makeAnswer() -> Int {
        var number = [Int]()
        while number.count < 3 {
            var num: Int = 0
            if (number.isEmpty) {
                num = Int.random(in: 1...9)
            } else {
                num = Int.random(in: 0...9)
            }
            if !number.contains(num) {
                number.append(num)
            }
        }
        return number.reduce(0) { $0 * 10 + $1 }
    }
    //MARK: - 유저입력 처리
    func getUserInput() -> [Int]? {
        print("3자리 숫자를 입력하세요 (예: 123): ", terminator: "")
        guard let input = readLine(), input.count == 3, let number = Int(input) else {
            print("유효하지 않은 입력입니다. 3자리 숫자를 입력해주세요.")
            return nil
        }
        
        let digits = Array(String(number)).compactMap { $0.wholeNumberValue }
        return digits.count == 3 ? digits : nil
    }
    
    //MARK: - 스트라이크, 볼 추론
    func calculateScore(secret:[Int], guess:[Int]) ->(strikes:Int, balls: Int) {
        var strikes = 0
        var balls = 0
        
        for (i, num) in guess.enumerated() {
            if secret.contains(num) {
                if secret[i] == num {
                    strikes += 1
                } else { balls += 1 }
            }
            
        }
        return (strikes, balls)
    }
    //MARK: - 게임 구동
    func Start() {
        functionCallCount += 1
        let secretNumber = Array(String(makeAnswer())).compactMap { $0.wholeNumberValue }
        var attempts = 0
        var isRunning = true
        print(secretNumber)
        
        while isRunning {
            attempts += 1
            
            guard let userInput = getUserInput() else { continue }
            
            let score = calculateScore(secret: secretNumber, guess: userInput)
            print("스트라이크: \(score.strikes), 볼: \(score.balls)")
            if score.strikes == 3 {
                print("축하합니다! \(attempts)번 만에 맞추셨습니다.")
                print("< 숫자 게임이 끝났습니다. >")
                gameCount.append(currentNumber)
                currentNumber += 1
                tryCount.append(attempts)
                isRunning = false
                MainMenu()
            }
            
        }
    }
    //MARK: - 게임 시작 메뉴
    func MainMenu() {
        var isRunning = true
        while isRunning {
            if functionCallCount == 0 {
                print("환영합니다! 원하시는 번호를 입력해주세요")
                print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
                print("선택: ", terminator: "")
            } else {
                print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
                print("선택: ", terminator: "")
            }
            guard let choice = readLine(), let option = Int(choice) else {
                print("유효하지 않은 입력입니다. 다시 시도해주세요.")
                continue
            }
            switch option {
            case 1:
                print("게임을 시작합니다!")
                Start()

            case 2:
                print("게임 기록을 보여줍니다.")
                showGameLog()
            case 3:
                print("< 숫자 게임을 종료합니다. >")
                isRunning = false
            default:
                print("유효하지 않은 선택입니다. 다시 시도해주세요.")
            }
        }
    }
    //MARK: - 게임기록확인 함수
    func showGameLog() {
        for(num1, num2) in  zip(gameCount, tryCount) {
            print("\(num1)번째 게임 : 시도 횟수 - \(num2)")
        }
    }


}

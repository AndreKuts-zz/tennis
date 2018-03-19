//
//  ViewController.swift
//  Tenis
//
//  Created by 1 on 07.03.2018.
//  Copyright © 2018 ANDRE.CORP. All rights reserved.


import UIKit

class ViewController: UIViewController {

    //view
    let gameScene = UIView()
    let ball = UIImageView()
    let whiteboard = UIView()
    let buttnStart = UIButton()
    let leftSideBoard = UIView()
    let rightSideDoard = UIView()
    
    var timer = Timer()
    
    var direction = Direction(horizontal: .Left, vertical: .Up)
    var speed = Speed(speed: 7)

    
    
    
    // MARK: = VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        creatingAll()
        
        print(gameScene.frame.width)
        print(gameScene.frame.height)
    }
    
    

    // MARK: - Creating objects
    func creatingAll() {
        creatingGameScene()
        creatingBall()
        creatingWhiteboard()
        makeButtonNewGame()
        makeLine()
        addLeftRightBoard()
    }
    
    func addLeftRightBoard() {
        leftSideBoard.frame = CGRect(x: 0, y: 0,
                                     width: whiteboard.frame.width / 4, height: whiteboard.frame.height)
        leftSideBoard.backgroundColor = .green
        whiteboard.addSubview(leftSideBoard)
        rightSideDoard.frame = CGRect(x: (whiteboard.frame.width / 4) * 3, y: 0,
                                      width: whiteboard.frame.width / 4, height: whiteboard.frame.height)
        rightSideDoard.backgroundColor = .green
        whiteboard.addSubview(rightSideDoard)
    }
    
    func makeButtonNewGame() {
        buttnStart.center = CGPoint(x: gameScene.center.x / 2, y: gameScene.center.y / 2)
        buttnStart.frame.size = CGSize(width: gameScene.frame.width / 2, height: 40)
        buttnStart.backgroundColor = .white
        buttnStart.layer.cornerRadius = 7.5
        buttnStart.setTitle("Start", for: .normal)
        buttnStart.setTitleColor(.black, for: .normal)
        gameScene.addSubview(buttnStart)
        buttnStart.addTarget(self, action: #selector(touchButtot), for: UIControlEvents.touchUpInside)
    }
    
    @objc func touchButtot() {
        buttnStart.setTitleColor(.lightGray, for: .highlighted)
        buttnStart.isHidden = true
        runTimer()
    }
    
    func makeLine() {
        let line = UIView(frame: CGRect(x:0, y: gameScene.frame.height - 50,
                                        width: gameScene.frame.width, height: 1))
        line.backgroundColor = .black
        gameScene.addSubview(line)
    }
    
    func creatingGameScene() {
        view.addSubview(gameScene)
        gameScene.frame = CGRect(x: 0, y: view.frame.height / 4, width: view.frame.width, height: view.frame.width)
        gameScene.backgroundColor = .gray
        gameScene.clipsToBounds = true
        gameScene.isMultipleTouchEnabled = false
    }
    
    func creatingBall() {
        ball.frame = CGRect(x: gameScene.center.x / 2, y: gameScene.center.y / 2,
                            width: 15, height: 15)
        ball.backgroundColor = .red
        ball.layer.cornerRadius = ball.frame.height / 2
        gameScene.addSubview(ball)
    }
    
    func creatingWhiteboard() {
        whiteboard.frame = CGRect(x: gameScene.center.x, y: gameScene.frame.width - 50, width: gameScene.frame.width / 2, height: 15)
        whiteboard.backgroundColor = .blue
        whiteboard.layer.cornerRadius = 10
        whiteboard.clipsToBounds = true
        gameScene.addSubview(whiteboard)
    }
    
    
    // MARK: - Timer & start game
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0 / 80.0, target: self,
                                     selector: #selector(startMoveBall), userInfo: nil, repeats: true)
    }
    
    @objc func startMoveBall() {
        reboundСheck()
        directinSet()
        recaptureBall()
        addDegreesToDirection()
    }
    
    // Проверка отсткока отскок от стены
    func reboundСheck() {
        if ball.center.x <= ball.frame.width / 2 {
            direction.horizontal = .Right
        } else if ball.center.x >= gameScene.frame.width - ball.frame.width / 2 {
            direction.horizontal = .Left
        } else if ball.center.y <= ball.frame.width / 2 {
            direction.vertical = .Down
        } else if ball.center.y >= gameScene.frame.height - ball.frame.width / 2 {
            direction.vertical = .Up
        }
    }
    
    // направление движения мяча
    func directinSet() {
        switch direction.horizontal {
        case .Left: moveLeft()
        case .Right: moveRight()
        }
        switch direction.vertical {
        case .Down: moveDown()
        case .Up: moveUp()
        }
    }
    
    
    func addDegreesToDirection() {
        if ball.center.y > whiteboard.center.y - whiteboard.frame.height {
            if ball.center.x > whiteboard.center.x - whiteboard.frame.width / 2 && ball.center.x < whiteboard.center.x - whiteboard.frame.width / 4 {
                speed.horizontalSpeed += (20 * (.pi / 180))
                speed.verticalSpeed -= (20 * (.pi / 180))
            }
        }
        if ball.center.y > whiteboard.center.y - whiteboard.frame.height {
            if ball.center.x > whiteboard.center.x + whiteboard.frame.width / 4 && ball.center.x < whiteboard.center.x + whiteboard.frame.width / 2 {
                speed.horizontalSpeed += 20 * .pi / 180
                speed.verticalSpeed -= 20 * .pi / 180
            }
        }
    }
    
    
    // Отбитие доской мячика
    func recaptureBall() {
        if ball.center.y > whiteboard.center.y - whiteboard.frame.height {
            if ball.center.x > whiteboard.center.x - whiteboard.frame.width / 2 &&
                ball.center.x < whiteboard.center.x + whiteboard.frame.width / 2 {
                direction.vertical = .Up
            } else {
                timer.invalidate()
                buttnStart.isHidden = false
                buttnStart.setTitle("New Game", for: .normal)
                buttnStart.addTarget(self, action: #selector(startNewGame), for: UIControlEvents.touchUpInside)
            }
        }
    }
    
    
    @objc func startNewGame() {
        buttnStart.isHidden = true
        ball.center = CGPoint(x: gameScene.center.x / 2, y: gameScene.center.y / 2)
        direction.vertical = .Up
        if  direction.horizontal == .Left {
            direction.horizontal = .Right
        } else {
            direction.horizontal = .Left
        }
        whiteboard.center.x = gameScene.center.x
        recaptureBall()
    }
    
    
    // MARK: - Move ball
    func moveUp() {
        ball.center.y = ball.center.y - speed.verticalSpeed
    }
    func moveDown() {
        ball.center.y = ball.center.y + speed.verticalSpeed
    }
    func moveLeft() {
        ball.center.x = ball.center.x - speed.horizontalSpeed
    }
    func moveRight() {
        ball.center.x = ball.center.x + speed.horizontalSpeed
    }
    
    
    // MARK: - touch to GameScene
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let piontTouch = touch?.location(in: gameScene) {
            whiteboard.center.x = piontTouch.x
            if (whiteboard.center.x - whiteboard.frame.width / 2) < 0 {
                whiteboard.center.x = 0 + whiteboard.frame.width / 2
            } else if (whiteboard.center.x + whiteboard.frame.width / 2) > gameScene.frame.width {
                whiteboard.center.x = gameScene.frame.width - whiteboard.frame.width / 2
            }
        }
    }
}













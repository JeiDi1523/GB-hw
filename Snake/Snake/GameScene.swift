//
//  GameScene.swift
//  Snake
//
//  Created by Денис Поволя on 18.06.2021.
//

import SpriteKit
import GameplayKit

struct CollisionCategories {
    static let Snake: UInt32 = 0x1 << 0
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32 = 0x1 << 2
    static let EdgeBody: UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        view.showsPhysics = true
        
        let counterClockwiseButtonOne = SKShapeNode()
        counterClockwiseButtonOne.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        
        counterClockwiseButtonOne.position = CGPoint(x: view.scene!.frame.minX + 30, y: scene!.frame.minY + 30)
        counterClockwiseButtonOne.fillColor = UIColor.gray
        counterClockwiseButtonOne.strokeColor = UIColor.gray
        counterClockwiseButtonOne.lineWidth = 10
        counterClockwiseButtonOne.name = "counterClockwiseButtonOne"
        
        let counterClockwiseButtonTwo = SKShapeNode()
        counterClockwiseButtonTwo.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        
        counterClockwiseButtonTwo.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30)
        counterClockwiseButtonTwo.fillColor = UIColor.gray
        counterClockwiseButtonTwo.strokeColor = UIColor.gray
        counterClockwiseButtonTwo.lineWidth = 10
        counterClockwiseButtonTwo.name = "counterClockwiseButtonTwo"
        
        self.addChild(counterClockwiseButtonOne)
        self.addChild(counterClockwiseButtonTwo)
        
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockwiseButtonOne" || touchNode.name == "counterClockwiseButtonTwo" else  {
                return
            }
            
            touchNode.fillColor = .green
            
            if touchNode.name == "counterClockwiseButtonOne" {
                snake!.moveCounterClockwise()
            } else if touchNode.name == "counterClockwiseButtonTwo" {
                snake!.moveClockwise()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockwiseButtonOne" || touchNode.name == "counterClockwiseButtonTwo" else  {
                return
            }
            
            touchNode.fillColor = .gray
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
    
    func createApple() {
        let randomX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 10)))
        let randomY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 10)))
        
        let apple = Apple(position: CGPoint(x: randomX, y: randomY))
        self.addChild(apple)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func gameOver() {
        let gameOver = SKLabelNode()
        gameOver.fontName = "San-Francisco-Bold"
        gameOver.text = "GAME OVER"
        gameOver.color = .white
        gameOver.fontSize = 60
        gameOver.position = CGPoint(x: frame.midX, y: frame.midY)
        scene?.removeAllChildren()
        addChild(gameOver)
    }
    
    func restartGame() {
        let gameScene: GameScene = GameScene(size: self.view!.bounds.size)
        gameScene.scaleMode = SKSceneScaleMode.fill
        self.view!.presentScene(gameScene)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes - CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
        case CollisionCategories.EdgeBody:
            gameOver()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.restartGame()
            }
        default:
            break
        }
    }
}

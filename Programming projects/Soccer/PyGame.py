import pygame
import random

pygame.init()

def CloseGame():
    pygame.quit()
    exit()

class Bot(pygame.sprite.Sprite):
    def __init__(self, x, y, filename, face):
        super().__init__(GameSprites)
        self.x = x
        self.y = y
        self.image = LoadImage(filename)
        self.rect = self.image.get_rect().move(self.x, self.y)
        self.speed = random.randint(5, 10)
        self.width = 104
        self.height = 35
        self.face = face
        self.add(Bots, GameSprites)

    def CheckFace(self):
        if self.rect.x <= 10:
            self.face = 1
        if self.rect.x >= 890 - self.width:
            self.face = 0

    def Moving(self):
        if self.face == 1:
            self.x += self.speed
            self.rect = self.image.get_rect().move(self.x, self.y)
        else:
            self.x -= self.speed
            self.rect = self.image.get_rect().move(self.x, self.y)

class Ball(pygame.sprite.Sprite):
    def __init__(self, x, y, filename):
        super().__init__(GameSprites)
        self.x = x
        self.y = y
        self.image = LoadImage(filename)
        self.width = 40
        self.height = 39
        self.speed = 5
        self.rect = self.image.get_rect().move(self.x, self.y)
        self.add(Balls, GameSprites)

    def CheckBall(self, sprite):
        global LastFace, Shoot

        if pygame.sprite.collide_rect(self, sprite):
            if LastFace == 'Up':
                self.y -= self.speed
                self.rect = self.image.get_rect().move(self.x, self.y)
            elif LastFace == 'Down':
                self.y += self.speed
                self.rect = self.image.get_rect().move(self.x, self.y)
            elif LastFace == 'Left':
                self.x -= self.speed
                self.rect = self.image.get_rect().move(self.x, self.y)
            elif LastFace == 'Right':
                self.x += self.speed
                self.rect = self.image.get_rect().move(self.x, self.y)

    def Shoot(self, sprite):
        global LastFace
        if pygame.sprite.collide_rect(self, sprite):
            if LastFace == 'Up':
                self.y -= self.speed + 150
                self.rect = self.image.get_rect().move(self.x, self.y)

            elif LastFace == 'Down':
                self.y += self.speed + 150
                self.rect = self.image.get_rect().move(self.x, self.y)

            elif LastFace == 'Left':
                self.x -= self.speed + 150
                self.rect = self.image.get_rect().move(self.x, self.y)

            elif LastFace == 'Right':
                self.x += self.speed + 150
                self.rect = self.image.get_rect().move(self.x, self.y)

    def Pass(self, sprite):
        global LastFace
        if pygame.sprite.collide_rect(self, sprite):
            if LastFace == 'Up':
                self.y -= self.speed + 50
                self.rect = self.image.get_rect().move(self.x, self.y)

            elif LastFace == 'Down':
                self.y += self.speed + 50
                self.rect = self.image.get_rect().move(self.x, self.y)

            elif LastFace == 'Left':
                self.x -= self.speed + 50
                self.rect = self.image.get_rect().move(self.x, self.y)

            elif LastFace == 'Right':
                self.x += self.speed + 50
                self.rect = self.image.get_rect().move(self.x, self.y)

    def Destroy(self, sprite):
        global  Bots, Empty
        if 260 <= self.rect.x <= 540 and self.rect.y <= 75:
            self.x = 430
            self.y = 580
            self.rect = self.image.get_rect().move(self.x, self.y)
            Bots.empty()
            Empty = True
        if 260 <= self.rect.x <= 540 and self.rect.y >= 690:
            self.x = 430
            self.y = 580
            self.rect = self.image.get_rect().move(self.x, self.y)
            Bots.empty()
            Empty = True
        if (260 > self.rect.x or self.rect.x > 540) and (self.rect.y <= 15 or self.rect.y >= 785):
            self.x = 430
            self.y = 580
            self.rect = self.image.get_rect().move(self.x, self.y)
            Bots.empty()
            Empty = True
        if self.rect.x < 10 or self.rect.x + self.width > 870:
            self.x = 430
            self.y = 580
            self.rect = self.image.get_rect().move(self.x, self.y)
            Bots.empty()
            Empty = True
        if pygame.sprite.collide_mask(self, sprite):
            self.x = 430
            self.y = 580
            self.rect = self.image.get_rect().move(self.x, self.y)
            Bots.empty()
            Empty = True



class Player(pygame.sprite.Sprite):
    def __init__(self, x, y, filename):
        super().__init__(GameSprites)
        self.x = x
        self.y = y
        self.image = LoadImage(filename)
        self.rect = self.image.get_rect().move(self.x, self.y)
        self.speedx = 6
        self.speedy = 6
        self.width = 104
        self.height = 35
        self.WalkUpNumber = 1
        self.WalkUp = [LoadImage('_RunUp1.png'), LoadImage('_RunUp1.png'),
                       LoadImage('_RunUp1.png'), LoadImage('_RunUp1.png'),
                       LoadImage('_RunUp2.png'), LoadImage('_RunUp2.png'),
                       LoadImage('_RunUp2.png'), LoadImage('_RunUp2.png')]
        self.WalkDownNumber = 1
        self.WalkDown = [LoadImage('_RunDown1.png'), LoadImage('_RunDown1.png'),
                         LoadImage('_RunDown1.png'), LoadImage('_RunDown1.png'),
                         LoadImage('_RunDown2.png'), LoadImage('_RunDown2.png'),
                         LoadImage('_RunDown2.png'), LoadImage('_RunDown2.png')]
        self.WalkLeftNumber = 1
        self.WalkLeft = [LoadImage('_RunLeft1.png'), LoadImage('_RunLeft1.png'),
                         LoadImage('_RunLeft1.png'), LoadImage('_RunLeft1.png'),
                         LoadImage('_RunLeft2.png'), LoadImage('_RunLeft2.png'),
                         LoadImage('_RunLeft2.png'), LoadImage('_RunLeft2.png')]
        self.WalkRightNumber = 1
        self.WalkRight = [LoadImage('_RunRight1.png'), LoadImage('_RunRight1.png'),
                          LoadImage('_RunRight1.png'), LoadImage('_RunRight1.png'),
                          LoadImage('_RunRight2.png'), LoadImage('_RunRight2.png'),
                          LoadImage('_RunRight2.png'), LoadImage('_RunRight2.png')]
        self.add(Players, GameSprites)

    def MoveUp(self):
        global LastFace
        if self.WalkUpNumber == 7:
            self.WalkUpNumber = 0
        else:
            self.WalkUpNumber += 1
            self.image = self.WalkUp[self.WalkUpNumber]
        self.y -= self.speedy
        self.rect = self.image.get_rect().move(self.x, self.y)
        LastFace = 'Up'

    def MoveDown(self):
        global LastFace
        if self.WalkDownNumber == 7:
            self.WalkDownNumber = 0
        else:
            self.WalkDownNumber += 1
            self.image = self.WalkDown[self.WalkDownNumber]
        self.y += self.speedy
        self.rect = self.image.get_rect().move(self.x, self.y)
        LastFace = 'Down'

    def MoveLeft(self):
        global LastFace
        if self.WalkLeftNumber == 7:
            self.WalkLeftNumber = 0
        else:
            self.WalkLeftNumber += 1
            self.image = self.WalkLeft[self.WalkLeftNumber]
        self.x -= self.speedx
        self.rect = self.image.get_rect().move(self.x, self.y)
        LastFace = 'Left'

    def MoveRight(self):
        global LastFace
        if self.WalkRightNumber == 7:
            self.WalkRightNumber = 0
        else:
            self.WalkRightNumber += 1
            self.image = self.WalkRight[self.WalkRightNumber]
        self.x += self.speedx
        self.rect = self.image.get_rect().move(self.x, self.y)
        LastFace = 'Right'

    def Collide(self):
        global Up, Down, Left, Right

        if 260 <= self.rect.x <= 540 and self.rect.y <= 75:
            Up = False
        elif 240 <= self.rect.x <= 270 and (self.rect.y <= 75 or self.rect.y >= 690):
            Right = False
        elif 540 <= self.rect.x <= 560 and (self.rect.y <= 75 or self.rect.y >= 690):
            Left = False
        elif 260 <= self.rect.x <= 540 and 690 <= self.rect.y:
            Down = False
        else:
            Left = True
            Right = True
            Up = True
            Down = True



class Goal(pygame.sprite.Sprite):
    def __init__(self, x, y, filename):
        super().__init__(GameSprites)
        self.x = x
        self.y = y
        self.image = LoadImage(filename)
        self.width = 270
        self.height = 80
        self.rect = self.image.get_rect().move(self.x, self.y)
        self.add(Goals, GameSprites)

def LoadImage(filename):
    filename = 'pic/' + filename
    try:
        image = pygame.image.load(filename)
    except:
        print('Невозможно загрузить картинку')
        raise exit()
    return image

background = LoadImage('_background.png')

size = width, height = (900, 800)
fps = 30
running = True
Up = True
Down = True
Left = True
Right = True
Empty=False

clock = pygame.time.Clock()
GameWindow = pygame.display.set_mode(size)
pygame.display.set_caption("2D soccer")
GameSprites = pygame.sprite.Group()
Goals = pygame.sprite.Group()
PlayerGoal = Goal(350, 720, '_goal.png')
EnemyGoal = Goal(350, 20, '_goal1.png')
Players = pygame.sprite.Group()
Balls = pygame.sprite.Group()
FirstPlayer = Player(400, 650, '_StayUp.png')
PlayBall = Ball(430, 580, '_ball.png')
Bots = pygame.sprite.Group()
for i in range(8):
    Bot(random.randint(30, 870), random.randint(100, 530), '_bot.png', random.randint(0, 2))
Bot(400, 80, '_bot.png', 0)

while running:
    if Empty:
        for i in range(8):
            Bot(random.randint(30, 870), random.randint(100, 530), '_bot.png', random.randint(0, 2))
        Bot(400, 80, '_bot.png', 0)
        Empty = False

    for event in pygame.event.get():

        if event.type == pygame.KEYDOWN and event.key == pygame.K_SPACE:
            for sprite in Players:
                PlayBall.Shoot(sprite)
        if event.type == pygame.KEYDOWN and event.key == pygame.K_r:
            for sprite in Players:
                PlayBall.Pass(sprite)

        if event.type == pygame.QUIT:
            running = False
            CloseGame()

    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT] and FirstPlayer.x > 10 and Left:
        FirstPlayer.MoveLeft()
    elif keys[pygame.K_RIGHT] and FirstPlayer.x < 890 - FirstPlayer.width and Right:
        FirstPlayer.MoveRight()
    elif keys[pygame.K_UP] and FirstPlayer.y > 10 and Up:
        FirstPlayer.MoveUp()
    elif keys[pygame.K_DOWN] and FirstPlayer.y < 790 - FirstPlayer.height and Down:
        FirstPlayer.MoveDown()


    GameWindow.blit(background, (0, 0))
    Balls.draw(GameWindow)
    Players.draw(GameWindow)
    Bots.draw(GameWindow)
    Goals.draw(GameWindow)

    for sprite in Players:
        sprite.Collide()
        PlayBall.CheckBall(sprite)

    for sprite in Bots:
        PlayBall.Destroy(sprite)
        sprite.CheckFace()
        sprite.Moving()

    pygame.display.update()
    clock.tick(fps)
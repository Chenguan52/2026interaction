PImage bgImg;
PImage imgLeft, imgRight, imgUp, imgDown;
PImage activeCharImg; // 目前顯示的角色方向圖片

PFont hudFont;

float offsetX = 0;       // 背景左上角 X
float offsetY = 0;       // 背景左上角 Y
float imgScale = 1.0;    // 背景縮放倍率

float charX;             // 角色中心 X
float charY;             // 角色中心 Y
float charScale = 0.25;  // 角色固定顯示倍率
float moveSpeed = 6;     // 每幀移動速度
float minMargin = 100;   // 角色中心與視窗邊界的最短距離（像素）

boolean upKey, downKey, leftKey, rightKey;

void setup() {
  size(800, 600);
  bgImg = loadImage("forest.2.png");

  // 四個方向的角色圖片（請放入 data 資料夾，並依實際檔名調整）
  imgLeft  = loadImage("GreatWolf_west.png");
  imgRight = loadImage("GreatWolf_east.png");
  imgUp    = loadImage("GreatWolf_north.png");
  imgDown  = loadImage("GreatWolf_south.png");

  // 預設朝左（或預設圖片）
  activeCharImg = (imgLeft != null) ? imgLeft : imgRight;

  charX = width / 2.0;
  charY = height / 2.0;

  // 載入支援中文的字型，避免左上角出現方框亂碼
  hudFont = createFont("Microsoft JhengHei", 13, true);
  if (hudFont != null) {
    textFont(hudFont);
  }
}

void draw() {
  background(30);

  updateCameraAndCharacter();

  // 1. 繪製背景
  float drawW = bgImg.width * imgScale;
  float drawH = bgImg.height * imgScale;
  imageMode(CORNER);
  image(bgImg, offsetX, offsetY, drawW, drawH);

  // 2. 繪製目前方向的角色圖片
  if (activeCharImg != null) {
    float charW = activeCharImg.width * charScale;
    float charH = activeCharImg.height * charScale;
    imageMode(CENTER);
    image(activeCharImg, charX, charY, charW, charH);
    imageMode(CORNER);
  }

  drawHUD();
}

void updateFacingDirection(float dirX, float dirY) {
  // 水平優先（若同時按斜向，可依需求調整先後順序）
  if (dirX < 0 && imgLeft != null) {
    activeCharImg = imgLeft;
  } else if (dirX > 0 && imgRight != null) {
    activeCharImg = imgRight;
  } else if (dirY < 0 && imgUp != null) {
    activeCharImg = imgUp;
  } else if (dirY > 0 && imgDown != null) {
    activeCharImg = imgDown;
  }
}

void updateCameraAndCharacter() {
  float drawW = bgImg.width * imgScale;
  float drawH = bgImg.height * imgScale;
  float centerX = width / 2.0;
  float centerY = height / 2.0;

  float dirX = 0;
  float dirY = 0;
  if (leftKey)  dirX -= 1;
  if (rightKey) dirX += 1;
  if (upKey)    dirY -= 1;
  if (downKey)  dirY += 1;

  // 有按方向鍵時更新角色面向圖片
  if (dirX != 0 || dirY != 0) {
    updateFacingDirection(dirX, dirY);
  }

  // --- 水平方向 ---
  if (dirX != 0) {
    float desired = dirX * moveSpeed;

    if (drawW <= width) {
      offsetX = (width - drawW) / 2.0;
      charX += desired;
    } else {
      boolean returningToCenter = (charX > centerX && dirX < 0) || (charX < centerX && dirX > 0);

      if (returningToCenter) {
        float prevCharX = charX;
        if (dirX < 0) {
          charX = max(centerX, charX + desired);
        } else {
          charX = min(centerX, charX + desired);
        }
        float usedByChar = abs(charX - prevCharX);
        float remSpeed = max(0, abs(desired) - usedByChar);

        if (remSpeed > 0) {
          float minOffsetX = width - drawW;
          float maxOffsetX = 0;
          offsetX = constrain(offsetX - dirX * remSpeed, minOffsetX, maxOffsetX);
        }
      } else {
        float minOffsetX = width - drawW;
        float maxOffsetX = 0;
        float prevOffsetX = offsetX;
        offsetX = constrain(offsetX - desired, minOffsetX, maxOffsetX);
        float actualBgShiftX = prevOffsetX - offsetX;
        float remX = desired - actualBgShiftX;
        charX += remX;
      }
    }
  }

  // --- 垂直方向 ---
  if (dirY != 0) {
    float desired = dirY * moveSpeed;

    if (drawH <= height) {
      offsetY = (height - drawH) / 2.0;
      charY += desired;
    } else {
      boolean returningToCenter = (charY > centerY && dirY < 0) || (charY < centerY && dirY > 0);

      if (returningToCenter) {
        float prevCharY = charY;
        if (dirY < 0) {
          charY = max(centerY, charY + desired);
        } else {
          charY = min(centerY, charY + desired);
        }
        float usedByChar = abs(charY - prevCharY);
        float remSpeed = max(0, abs(desired) - usedByChar);

        if (remSpeed > 0) {
          float minOffsetY = height - drawH;
          float maxOffsetY = 0;
          offsetY = constrain(offsetY - dirY * remSpeed, minOffsetY, maxOffsetY);
        }
      } else {
        float minOffsetY = height - drawH;
        float maxOffsetY = 0;
        float prevOffsetY = offsetY;
        offsetY = constrain(offsetY - desired, minOffsetY, maxOffsetY);
        float actualBgShiftY = prevOffsetY - offsetY;
        float remY = desired - actualBgShiftY;
        charY += remY;
      }
    }
  }

  // 限制角色中心與視窗邊界的最短距離不小於 minMargin
  float effectiveMarginX = min(minMargin, centerX);
  float effectiveMarginY = min(minMargin, centerY);
  charX = constrain(charX, effectiveMarginX, width - effectiveMarginX);
  charY = constrain(charY, effectiveMarginY, height - effectiveMarginY);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT)  leftKey = true;
    if (keyCode == RIGHT) rightKey = true;
    if (keyCode == UP)    upKey = true;
    if (keyCode == DOWN)  downKey = true;
  } else if (key == '+' || key == '=') {
    zoomAtCenter(1.15);
  } else if (key == '-') {
    zoomAtCenter(1.0 / 1.15);
  } else if (key == '0') {
    imgScale = 1.0;
    offsetX = 0;
    offsetY = 0;
    charX = width / 2.0;
    charY = height / 2.0;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT)  leftKey = false;
    if (keyCode == RIGHT) rightKey = false;
    if (keyCode == UP)    upKey = false;
    if (keyCode == DOWN)  downKey = false;
  }
}

void mouseWheel(MouseEvent event) {
  float factor = (event.getCount() < 0) ? 1.1 : (1.0 / 1.1);
  zoomAtCenter(factor);
  limitBackgroundOnly();
}

void zoomAtCenter(float factor) {
  float prevScale = imgScale;
  imgScale = constrain(imgScale * factor, 0.2, 5.0);
  float actualFactor = imgScale / prevScale;

  float cx = width / 2.0;
  float cy = height / 2.0;
  offsetX = cx - (cx - offsetX) * actualFactor;
  offsetY = cy - (cy - offsetY) * actualFactor;
}

void limitBackgroundOnly() {
  float drawW = bgImg.width * imgScale;
  float drawH = bgImg.height * imgScale;

  if (drawW <= width) {
    offsetX = (width - drawW) / 2.0;
  } else {
    offsetX = constrain(offsetX, width - drawW, 0);
  }

  if (drawH <= height) {
    offsetY = (height - drawH) / 2.0;
  } else {
    offsetY = constrain(offsetY, height - drawH, 0);
  }
}

void drawHUD() {
  fill(0, 160);
  noStroke();
  rect(10, 10, 410, 52, 6);

  fill(255);
  textSize(13);
  text("往邊緣：背景先動、到底換角色 | 往回走：角色先回中心", 20, 32);
  text("背景: (" + int(offsetX) + ", " + int(offsetY) + ") | 角色: (" + int(charX) + ", " + int(charY) + ")", 20, 50);
}

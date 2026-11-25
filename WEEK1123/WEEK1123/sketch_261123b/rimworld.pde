PImage bgImg;
PImage imgLeft, imgRight, imgUp, imgDown;
PImage activeCharImg;

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

class AxisResult {
  float offset;
  float charPos;

  AxisResult(float offset, float charPos) {
    this.offset = offset;
    this.charPos = charPos;
  }
}

class MapProp {
  PImage img;
  float worldX, worldY; // 在原始背景圖上的座標（像素）
  float propScale;      // 物件自身縮放倍率

  MapProp(PImage img, float worldX, float worldY, float propScale) {
    this.img = img;
    this.worldX = worldX;
    this.worldY = worldY;
    this.propScale = propScale;
  }

  void display(float offsetX, float offsetY, float bgScale) {
    if (img == null) return;
    float screenX = offsetX + worldX * bgScale;
    float screenY = offsetY + worldY * bgScale;
    float w = img.width * propScale * bgScale;
    float h = img.height * propScale * bgScale;

    imageMode(CENTER);
    image(img, screenX, screenY, w, h);
    imageMode(CORNER);
  }
}

ArrayList<MapProp> props = new ArrayList<MapProp>();

void setup() {
  size(800, 600);
  bgImg = loadImage("forest.2.png");

  imgLeft  = loadImage("GreatWolf_west.png");
  imgRight = loadImage("GreatWolf_east.png");
  imgUp    = loadImage("GreatWolf_north.png");
  imgDown  = loadImage("GreatWolf_south.png");

  activeCharImg = (imgLeft != null) ? imgLeft : imgRight;

  charX = width / 2.0;
  charY = height / 2.0;

  hudFont = createFont("Microsoft JhengHei", 13, true);
  if (hudFont != null) {
    textFont(hudFont);
  }

  // 1. 初始化地圖物件
  initProps();
}

void draw() {
  background(30);

  updateCameraAndCharacter();

  // 1. 繪製背景
  float drawW = bgImg.width * imgScale;
  float drawH = bgImg.height * imgScale;
  imageMode(CORNER);
  image(bgImg, offsetX, offsetY, drawW, drawH);

  // 2. 繪製背景上的物件（跟著背景平移與縮放）
  drawProps();

  // 3. 繪製目前方向的角色圖片
  if (activeCharImg != null) {
    float charW = activeCharImg.width * charScale;
    float charH = activeCharImg.height * charScale;
    imageMode(CENTER);
    image(activeCharImg, charX, charY, charW, charH);
    imageMode(CORNER);
  }
  
  //體力條
  fill(50);
  rect(0, 550, 800, 50);



  drawHUD();
}


//物件增加
void initProps() {
  props.clear();
  PImage meatImg = loadImage("meat.png"); // 請確認圖片放在 data 資料夾
  if (meatImg != null && bgImg != null) {
    float padding = 60;
    float randX = random(padding, max(padding + 1, bgImg.width - padding));
    float randY = random(padding, max(padding + 1, bgImg.height - padding));

    props.add(new MapProp(meatImg, randX, randY, 0.5));
    props.add(new MapProp(meatImg, 720, 460, 0.5));
  }
}

void drawProps() {
  for (MapProp p : props) {
    p.display(offsetX, offsetY, imgScale);
  }
}

//


void updateFacingDirection(float dirX, float dirY) {
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

  float dirX = (rightKey ? 1 : 0) - (leftKey ? 1 : 0);
  float dirY = (downKey ? 1 : 0) - (upKey ? 1 : 0);

  if (dirX != 0 || dirY != 0) {
    updateFacingDirection(dirX, dirY);
  }

  AxisResult xRes = stepAxisRelay(dirX, moveSpeed, offsetX, charX, width, drawW, minMargin);
  offsetX = xRes.offset;
  charX = xRes.charPos;

  AxisResult yRes = stepAxisRelay(dirY, moveSpeed, offsetY, charY, height, drawH, minMargin);
  offsetY = yRes.offset;
  charY = yRes.charPos;
}

AxisResult stepAxisRelay(
  float dir,
  float speed,
  float currentOffset,
  float currentCharPos,
  float viewSize,
  float bgSize,
  float margin
) {
  float centerPos = viewSize / 2.0;
  float nextOffset = currentOffset;
  float nextCharPos = currentCharPos;

  if (dir != 0) {
    float desired = dir * speed;

    if (bgSize <= viewSize) {
      nextOffset = (viewSize - bgSize) / 2.0;
      nextCharPos += desired;
    } else {
      float minOffset = viewSize - bgSize;
      float maxOffset = 0;

      boolean returningToCenter =
        (nextCharPos > centerPos && dir < 0) ||
        (nextCharPos < centerPos && dir > 0);

      if (returningToCenter) {
        float prevChar = nextCharPos;
        nextCharPos = (dir < 0)
          ? max(centerPos, nextCharPos + desired)
          : min(centerPos, nextCharPos + desired);

        float usedByChar = abs(nextCharPos - prevChar);
        float remSpeed = max(0, abs(desired) - usedByChar);

        if (remSpeed > 0) {
          nextOffset = constrain(nextOffset - dir * remSpeed, minOffset, maxOffset);
        }
      } else {
        float prevOffset = nextOffset;
        nextOffset = constrain(nextOffset - desired, minOffset, maxOffset);
        float actualBgShift = prevOffset - nextOffset;
        nextCharPos += (desired - actualBgShift);
      }
    }
  }

  float effectiveMargin = min(margin, centerPos);
  nextCharPos = constrain(nextCharPos, effectiveMargin, viewSize - effectiveMargin);

  return new AxisResult(nextOffset, nextCharPos);
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

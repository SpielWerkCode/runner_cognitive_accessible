# Cat Jump Game

A simple Flutter game designed for cognitively impaired users, where a cat jumps over obstacles to earn rewards.

## Description

**start_screen**  
- Background image and start button  
- 5 **reward_off.png** icons which turn into **reward.png** after the first 4 successful rounds each  

**game_screen**  
- **cat.png**, **cat_jump.png** jumping over obstacles:  
  **dog**, **doghouse**, **fence**, **hen**, **pond**  
- If the cat fails to jump, **collision.png** is displayed  

**reward_screen**  
- **image_reward.gif** plays after 5 successful rounds  

## Known Issues

- The game runs too fast on tablets. Adjust to use relative values instead of absolute pixel-based ones. Background and obstacle speeds need to be synchronized.
- Obstacles (**dog**, **doghouse**, **fence**, **hen**, **pond**, **basket**) should appear randomly, but not directly one after another.
- Occasional crash occurs shortly before the end of a round, right before switching back to **start_screen**.
- On the **reward_screen**, the **image_reward.gif** plays correctly the first time. On subsequent runs it only shows frame 1 on the second run, frame 2 on the third, frame 3 on the fourth.

## Status

Prototype / work in progress.

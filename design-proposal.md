---
title: "Design Proposal"
author: Haoting Chen
email: u72278771@anu.edu.au
---

In the light show, I will contain the following content. LEDs light up one by one to form different patterns such as a spiral and a "#" and turn off in the reverse order. A text “Welcome to COMP2300” moves through the screen. Patterns blink with sounds (if time allowes).

I will encode each frame of animation of the LEDs as a 25-bit binary number and store it into a specific location in the memory. I will also write a helper function which can read the encoding in that location and turns it into actual LEDs commands. In this way, I can easily show different patterns by storing different encodings to that memory location through instructions in Main. Between every two instructions, a delay function may be used to control the playing speed. Since we can only control a whole line or column of LEDs, some LEDs may be unavoidably turned on. Therefore, I decide to split the image into 5 lines and let the 5 lines of LEDs light up in turn in a very short time to form a fake static image.

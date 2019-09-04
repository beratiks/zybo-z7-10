# RGB Led Control Pwm and Implement Multiply Components

3 buttons controller duty. Increase duty when pressed and set duty zero at overload.
3 switches on-off pwm of each r-g-b leds

Features : 

- Start - Stop Pwm
- Change frequency at run
- Change duty at run

Design : 

There is 3 modules
- TopModule : Use components to set duty and on - off r-g-b leds
- PwmModule : Pwm creation
- ButtonDebouncerModule : Button's debounce control

How to read more keys from keyboard
- add more **key** deceleration and more **UsbRead()** in **main.c**, see line 52 and 522.
- add more **keycode_base** deceleration in **io_handler.h**

Things worth noting here:

- The data bus to the EZ-OTG chip is only 16 bits wide. 
- That means with this setup you can only get information about two keys on the keyboard simultaneously using one UsbRead().
- The first two keycode are stored in 0x051E. Other keycode are in subsequent addresses.
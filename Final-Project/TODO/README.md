# Project Tree
```
Final-Project                   
├─ .gitignore                   
├─ ball.sv                      
├─ ballController.sv            
├─ Color_Mapper.sv              
├─ game_logic.sv                
├─ HexDriver.sv                 
├─ hpi_io_intf.sv               
├─ lab8_soc.qsys                
├─ lab8_soc.sopcinfo            
├─ README.md                    
├─ ship.sv                      
├─ software                     
│  ├─ cy7c67200.h               
│  ├─ io_handler.c              
│  ├─ io_handler.h              
│  ├─ lcp_cmd.h                 
│  ├─ lcp_data.h                
│  ├─ main.c                    
│  ├─ note.md                   
│  ├─ usb.c                     
│  └─ usb.h                     
├─ top_level.sv                 
├─ vga_clk.ppf                  
├─ vga_clk.qip                  
├─ vga_clk.v                    
├─ VGA_controller.sv            
└─ workspace.code-workspace     

```

# Weekly Schedule & To Do List

## Programming Tasks
- Write **top_level.sv**
  - define some parameters, such as:
    - constant speed for shell, 
    - acceleration for ship, 
    - angle velocity for ship, 
    - maximum speed for ship.
- Modify **ball.sv** and ballController.sv in order to control the **shell** 炮弹 movement.
  - Main difficulty is to add **angle** information in radians, and **speed**.
  - Rewrite movement algorithm with **angle** and **speed**.
- Write **ship.sv** to module a ship in order to control the **ship** movement.
  - Main difficulty is to add **angle** information in radians, and **speed**.
  - Rewrite movement algorithm with **angle** and **speed**.
- Write cooperation between shell and ship.sv
  - initial position of shell is determined by ship position, and angle is determined ship angle.
    - In the future, we may add independent angle control for shell.
- Compile the function to read more keys from keyboard.

## Technology and Reading Tasks
- spirits
- store

## GitHub Pages
- https://github.com/tlietz/FPGA_Video_Game_2D_Shooter
- https://github.com/neiman3/basys3battleship
- https://github.com/xddxdd/zjui-ece385-final